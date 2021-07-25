using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace Comies.Migrations
{
    public partial class Customer : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Addresses_Costumers_CostumerId",
                table: "Addresses");

            migrationBuilder.DropForeignKey(
                name: "FK_Orders_Costumers_CostumerId",
                table: "Orders");

            migrationBuilder.DropForeignKey(
                name: "FK_Phones_Costumers_CostumerId",
                table: "Phones");

            migrationBuilder.DropTable(
                name: "Costumers");

            migrationBuilder.DropIndex(
                name: "IX_Orders_CostumerId_StoreId_Placed",
                table: "Orders");

            migrationBuilder.DropColumn(
                name: "CostumerId",
                table: "Orders");

            migrationBuilder.RenameColumn(
                name: "CostumerId",
                table: "Phones",
                newName: "CustomerId");

            migrationBuilder.RenameIndex(
                name: "IX_Phones_CostumerId",
                table: "Phones",
                newName: "IX_Phones_CustomerId");

            migrationBuilder.RenameColumn(
                name: "CostumerId",
                table: "Addresses",
                newName: "CustomerId");

            migrationBuilder.RenameIndex(
                name: "IX_Addresses_CostumerId",
                table: "Addresses",
                newName: "IX_Addresses_CustomerId");

            migrationBuilder.AlterColumn<Guid>(
                name: "AddressId",
                table: "Orders",
                type: "uniqueidentifier",
                nullable: true,
                oldClrType: typeof(Guid),
                oldType: "uniqueidentifier",
                oldMaxLength: 10);

            migrationBuilder.AddColumn<Guid>(
                name: "CustomerId",
                table: "Orders",
                type: "uniqueidentifier",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "CustomerName",
                table: "Orders",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.CreateTable(
                name: "Customers",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    Name = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: false),
                    Document = table.Column<string>(type: "nvarchar(20)", maxLength: 20, nullable: true),
                    MemberSince = table.Column<DateTime>(type: "datetime2", nullable: false),
                    Active = table.Column<bool>(type: "bit", nullable: false),
                    CreationDate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    StoreId = table.Column<Guid>(type: "uniqueidentifier", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Customers", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Customers_Stores_StoreId",
                        column: x => x.StoreId,
                        principalTable: "Stores",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateIndex(
                name: "IX_Orders_CustomerId_StoreId_Placed",
                table: "Orders",
                columns: new[] { "CustomerId", "StoreId", "Placed" },
                unique: true,
                filter: "[CustomerId] IS NOT NULL");

            migrationBuilder.CreateIndex(
                name: "IX_Customers_Id_StoreId",
                table: "Customers",
                columns: new[] { "Id", "StoreId" },
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_Customers_StoreId",
                table: "Customers",
                column: "StoreId");

            migrationBuilder.AddForeignKey(
                name: "FK_Addresses_Customers_CustomerId",
                table: "Addresses",
                column: "CustomerId",
                principalTable: "Customers",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Orders_Customers_CustomerId",
                table: "Orders",
                column: "CustomerId",
                principalTable: "Customers",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Phones_Customers_CustomerId",
                table: "Phones",
                column: "CustomerId",
                principalTable: "Customers",
                principalColumn: "Id");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Addresses_Customers_CustomerId",
                table: "Addresses");

            migrationBuilder.DropForeignKey(
                name: "FK_Orders_Customers_CustomerId",
                table: "Orders");

            migrationBuilder.DropForeignKey(
                name: "FK_Phones_Customers_CustomerId",
                table: "Phones");

            migrationBuilder.DropTable(
                name: "Customers");

            migrationBuilder.DropIndex(
                name: "IX_Orders_CustomerId_StoreId_Placed",
                table: "Orders");

            migrationBuilder.DropColumn(
                name: "CustomerId",
                table: "Orders");

            migrationBuilder.DropColumn(
                name: "CustomerName",
                table: "Orders");

            migrationBuilder.RenameColumn(
                name: "CustomerId",
                table: "Phones",
                newName: "CostumerId");

            migrationBuilder.RenameIndex(
                name: "IX_Phones_CustomerId",
                table: "Phones",
                newName: "IX_Phones_CostumerId");

            migrationBuilder.RenameColumn(
                name: "CustomerId",
                table: "Addresses",
                newName: "CostumerId");

            migrationBuilder.RenameIndex(
                name: "IX_Addresses_CustomerId",
                table: "Addresses",
                newName: "IX_Addresses_CostumerId");

            migrationBuilder.AlterColumn<Guid>(
                name: "AddressId",
                table: "Orders",
                type: "uniqueidentifier",
                maxLength: 10,
                nullable: false,
                defaultValue: new Guid("00000000-0000-0000-0000-000000000000"),
                oldClrType: typeof(Guid),
                oldType: "uniqueidentifier",
                oldNullable: true);

            migrationBuilder.AddColumn<Guid>(
                name: "CostumerId",
                table: "Orders",
                type: "uniqueidentifier",
                nullable: false,
                defaultValue: new Guid("00000000-0000-0000-0000-000000000000"));

            migrationBuilder.CreateTable(
                name: "Costumers",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    Active = table.Column<bool>(type: "bit", nullable: false),
                    CreationDate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    Document = table.Column<string>(type: "nvarchar(20)", maxLength: 20, nullable: true),
                    MemberSince = table.Column<DateTime>(type: "datetime2", nullable: false),
                    Name = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Costumers", x => x.Id);
                });

            migrationBuilder.CreateIndex(
                name: "IX_Orders_CostumerId_StoreId_Placed",
                table: "Orders",
                columns: new[] { "CostumerId", "StoreId", "Placed" },
                unique: true);

            migrationBuilder.AddForeignKey(
                name: "FK_Addresses_Costumers_CostumerId",
                table: "Addresses",
                column: "CostumerId",
                principalTable: "Costumers",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Orders_Costumers_CostumerId",
                table: "Orders",
                column: "CostumerId",
                principalTable: "Costumers",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Phones_Costumers_CostumerId",
                table: "Phones",
                column: "CostumerId",
                principalTable: "Costumers",
                principalColumn: "Id");
        }
    }
}
