using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace Comies.Migrations
{
    public partial class StockId : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "Color",
                table: "ProductsCategories",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.AddColumn<Guid>(
                name: "StockId",
                table: "Products",
                type: "uniqueidentifier",
                nullable: true);

            migrationBuilder.AddColumn<Guid>(
                name: "StockId1",
                table: "Products",
                type: "uniqueidentifier",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_Products_StockId1",
                table: "Products",
                column: "StockId1");

            migrationBuilder.AddForeignKey(
                name: "FK_Products_Stocks_StockId1",
                table: "Products",
                column: "StockId1",
                principalTable: "Stocks",
                principalColumn: "Id");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Products_Stocks_StockId1",
                table: "Products");

            migrationBuilder.DropIndex(
                name: "IX_Products_StockId1",
                table: "Products");

            migrationBuilder.DropColumn(
                name: "Color",
                table: "ProductsCategories");

            migrationBuilder.DropColumn(
                name: "StockId",
                table: "Products");

            migrationBuilder.DropColumn(
                name: "StockId1",
                table: "Products");
        }
    }
}
