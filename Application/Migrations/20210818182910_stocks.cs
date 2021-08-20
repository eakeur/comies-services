using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace Comies.Migrations
{
    public partial class stocks : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropIndex(
                name: "IX_Stocks_ProductId_StoreId",
                table: "Stocks");

            migrationBuilder.DropColumn(
                name: "MainSupplierId",
                table: "Stocks");

            migrationBuilder.CreateIndex(
                name: "IX_Stocks_Id_StoreId",
                table: "Stocks",
                columns: new[] { "Id", "StoreId" },
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_Stocks_ProductId",
                table: "Stocks",
                column: "ProductId");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropIndex(
                name: "IX_Stocks_Id_StoreId",
                table: "Stocks");

            migrationBuilder.DropIndex(
                name: "IX_Stocks_ProductId",
                table: "Stocks");

            migrationBuilder.AddColumn<Guid>(
                name: "MainSupplierId",
                table: "Stocks",
                type: "uniqueidentifier",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_Stocks_ProductId_StoreId",
                table: "Stocks",
                columns: new[] { "ProductId", "StoreId" },
                unique: true);
        }
    }
}
