using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace Comies.Migrations
{
    public partial class ChangeProfileType : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "ProfilesDetails");

            migrationBuilder.AddColumn<bool>(
                name: "CanAddCustomer",
                table: "Profiles",
                type: "bit",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<bool>(
                name: "CanAddOrders",
                table: "Profiles",
                type: "bit",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<bool>(
                name: "CanAddProducts",
                table: "Profiles",
                type: "bit",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<bool>(
                name: "CanAddStock",
                table: "Profiles",
                type: "bit",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<bool>(
                name: "CanAddStore",
                table: "Profiles",
                type: "bit",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<bool>(
                name: "CanDelCustomer",
                table: "Profiles",
                type: "bit",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<bool>(
                name: "CanDelOrders",
                table: "Profiles",
                type: "bit",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<bool>(
                name: "CanDelProducts",
                table: "Profiles",
                type: "bit",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<bool>(
                name: "CanDelStock",
                table: "Profiles",
                type: "bit",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<bool>(
                name: "CanDelStore",
                table: "Profiles",
                type: "bit",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<bool>(
                name: "CanGetCustomer",
                table: "Profiles",
                type: "bit",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<bool>(
                name: "CanGetOrders",
                table: "Profiles",
                type: "bit",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<bool>(
                name: "CanGetProducts",
                table: "Profiles",
                type: "bit",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<bool>(
                name: "CanGetStock",
                table: "Profiles",
                type: "bit",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<bool>(
                name: "CanGetStore",
                table: "Profiles",
                type: "bit",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<bool>(
                name: "CanPutCustomer",
                table: "Profiles",
                type: "bit",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<bool>(
                name: "CanPutOrders",
                table: "Profiles",
                type: "bit",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<bool>(
                name: "CanPutProducts",
                table: "Profiles",
                type: "bit",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<bool>(
                name: "CanPutStock",
                table: "Profiles",
                type: "bit",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<bool>(
                name: "CanPutStore",
                table: "Profiles",
                type: "bit",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AlterColumn<Guid>(
                name: "ProfileId",
                table: "Operators",
                type: "uniqueidentifier",
                nullable: true,
                oldClrType: typeof(Guid),
                oldType: "uniqueidentifier");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "CanAddCustomer",
                table: "Profiles");

            migrationBuilder.DropColumn(
                name: "CanAddOrders",
                table: "Profiles");

            migrationBuilder.DropColumn(
                name: "CanAddProducts",
                table: "Profiles");

            migrationBuilder.DropColumn(
                name: "CanAddStock",
                table: "Profiles");

            migrationBuilder.DropColumn(
                name: "CanAddStore",
                table: "Profiles");

            migrationBuilder.DropColumn(
                name: "CanDelCustomer",
                table: "Profiles");

            migrationBuilder.DropColumn(
                name: "CanDelOrders",
                table: "Profiles");

            migrationBuilder.DropColumn(
                name: "CanDelProducts",
                table: "Profiles");

            migrationBuilder.DropColumn(
                name: "CanDelStock",
                table: "Profiles");

            migrationBuilder.DropColumn(
                name: "CanDelStore",
                table: "Profiles");

            migrationBuilder.DropColumn(
                name: "CanGetCustomer",
                table: "Profiles");

            migrationBuilder.DropColumn(
                name: "CanGetOrders",
                table: "Profiles");

            migrationBuilder.DropColumn(
                name: "CanGetProducts",
                table: "Profiles");

            migrationBuilder.DropColumn(
                name: "CanGetStock",
                table: "Profiles");

            migrationBuilder.DropColumn(
                name: "CanGetStore",
                table: "Profiles");

            migrationBuilder.DropColumn(
                name: "CanPutCustomer",
                table: "Profiles");

            migrationBuilder.DropColumn(
                name: "CanPutOrders",
                table: "Profiles");

            migrationBuilder.DropColumn(
                name: "CanPutProducts",
                table: "Profiles");

            migrationBuilder.DropColumn(
                name: "CanPutStock",
                table: "Profiles");

            migrationBuilder.DropColumn(
                name: "CanPutStore",
                table: "Profiles");

            migrationBuilder.AlterColumn<Guid>(
                name: "ProfileId",
                table: "Operators",
                type: "uniqueidentifier",
                nullable: false,
                defaultValue: new Guid("00000000-0000-0000-0000-000000000000"),
                oldClrType: typeof(Guid),
                oldType: "uniqueidentifier",
                oldNullable: true);

            migrationBuilder.CreateTable(
                name: "ProfilesDetails",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    Active = table.Column<bool>(type: "bit", nullable: false),
                    Allowed = table.Column<bool>(type: "bit", nullable: false),
                    AllowedToAdd = table.Column<bool>(type: "bit", nullable: false),
                    AllowedToDelete = table.Column<bool>(type: "bit", nullable: false),
                    AllowedToGet = table.Column<bool>(type: "bit", nullable: false),
                    AllowedToUpdate = table.Column<bool>(type: "bit", nullable: false),
                    CreationDate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    PermissionCode = table.Column<string>(type: "nvarchar(6)", maxLength: 6, nullable: true),
                    ProfileId = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    StoreId = table.Column<Guid>(type: "uniqueidentifier", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ProfilesDetails", x => x.Id);
                    table.ForeignKey(
                        name: "FK_ProfilesDetails_Profiles_ProfileId",
                        column: x => x.ProfileId,
                        principalTable: "Profiles",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_ProfilesDetails_Stores_StoreId",
                        column: x => x.StoreId,
                        principalTable: "Stores",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateIndex(
                name: "IX_ProfilesDetails_PermissionCode_StoreId_ProfileId",
                table: "ProfilesDetails",
                columns: new[] { "PermissionCode", "StoreId", "ProfileId" },
                unique: true,
                filter: "[PermissionCode] IS NOT NULL");

            migrationBuilder.CreateIndex(
                name: "IX_ProfilesDetails_ProfileId",
                table: "ProfilesDetails",
                column: "ProfileId");

            migrationBuilder.CreateIndex(
                name: "IX_ProfilesDetails_StoreId",
                table: "ProfilesDetails",
                column: "StoreId");
        }
    }
}
