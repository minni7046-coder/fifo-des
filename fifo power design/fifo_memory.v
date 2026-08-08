module low_power_fifo #(
    parameter DATA_WIDTH = 8,
    parameter DEPTH      = 8,
    parameter PTR_WIDTH  = 3
)(
    input  wire                  clk,
    input  wire                  reset,

    input  wire                  wr_en,
    input  wire                  rd_en,
    input  wire [DATA_WIDTH-1:0] data_in,

    output reg  [DATA_WIDTH-1:0] data_out,
    output wire                  full,
    output wire                  empty
);

    // FIFO memory
    reg [DATA_WIDTH-1:0] mem [0:DEPTH-1];

    // Read and write pointers
    reg [PTR_WIDTH-1:0] wr_ptr;
    reg [PTR_WIDTH-1:0] rd_ptr;

    // Number of stored elements
    reg [PTR_WIDTH:0] count;

    // FIFO status
    assign empty = (count == 0);
    assign full  = (count == DEPTH);

    // Write operation
    // Memory is accessed only when wr_en is active.
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            wr_ptr <= 0;
        end
        else if (wr_en && !full) begin
            mem[wr_ptr] <= data_in;
            wr_ptr <= wr_ptr + 1'b1;
        end
    end

    // Read operation
    // Data output changes only when a valid read occurs.
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            rd_ptr   <= 0;
            data_out <= 0;
        end
        else if (rd_en && !empty) begin
            data_out <= mem[rd_ptr];
            rd_ptr <= rd_ptr + 1'b1;
        end
    end

    // FIFO occupancy counter
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            count <= 0;
        end
        else begin
            case ({wr_en && !full, rd_en && !empty})

                2'b10:
                    count <= count + 1'b1;

                2'b01:
                    count <= count - 1'b1;

                2'b11:
                    count <= count;

                default:
                    count <= count;

            endcase
        end
    end

endmodule