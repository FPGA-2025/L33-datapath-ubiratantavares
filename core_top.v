module core_top #(
    parameter MEMORY_FILE = "programa.txt"
)(
    input wire clk,
    input wire rst_n
);

   // Sinais internos para conectar o Core e a Memória
    wire rd_en_w;
    wire wr_en_w;
    wire [31:0] data_from_mem_w;
    wire [31:0] addr_to_mem_w;
    wire [31:0] data_to_mem_w;

    // Instanciação do módulo Core
    // O parâmetro BOOT_ADDRESS é configurado para iniciar o PC em 0
    Core #(
        .BOOT_ADDRESS(32'h00000000)
    ) u_core (
        .clk(clk),
        .rst_n(rst_n),
        .rd_en_o(rd_en_w),
        .wr_en_i(wr_en_w),
        .data_i(data_from_mem_w),
        .addr_o(addr_to_mem_w),
        .data_o(data_to_mem_w)
    );

    // Instanciação do módulo Memory
    // O nome da instância 'mem' é crucial para o testbench
    Memory #(
        .MEMORY_FILE(MEMORY_FILE)
    ) mem (
        .clk(clk),
        .rd_en_i(rd_en_w),
        .wr_en_i(wr_en_w),
        .addr_i(addr_to_mem_w),
        .data_i(data_to_mem_w),
        .data_o(data_from_mem_w),
        .ack_o()
    );

endmodule
