using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace comies_services.Migrations
{
    public partial class InitialCreate : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Costumers",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Document = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    MemberSince = table.Column<DateTime>(type: "datetime2", nullable: false),
                    Active = table.Column<bool>(type: "bit", nullable: false),
                    CreationDate = table.Column<DateTime>(type: "datetime2", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Costumers", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Stores",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    CompanyNickname = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    CompanyName = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Document = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    ContactName = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    MemberSince = table.Column<DateTime>(type: "datetime2", nullable: false),
                    StoreId = table.Column<int>(type: "int", nullable: false),
                    Active = table.Column<bool>(type: "bit", nullable: false),
                    CreationDate = table.Column<DateTime>(type: "datetime2", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Stores", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Stores_Stores_StoreId",
                        column: x => x.StoreId,
                        principalTable: "Stores",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "Addresses",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    CEP = table.Column<string>(type: "nvarchar(8)", maxLength: 8, nullable: false),
                    Number = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    District = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Complement = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Reference = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Street = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    City = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    State = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Country = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    CostumerId = table.Column<int>(type: "int", nullable: false),
                    Active = table.Column<bool>(type: "bit", nullable: false),
                    CreationDate = table.Column<DateTime>(type: "datetime2", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Addresses", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Addresses_Costumers_CostumerId",
                        column: x => x.CostumerId,
                        principalTable: "Costumers",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "Phones",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    DDD = table.Column<string>(type: "nvarchar(3)", maxLength: 3, nullable: true),
                    Number = table.Column<string>(type: "nvarchar(9)", maxLength: 9, nullable: false),
                    CostumerId = table.Column<int>(type: "int", nullable: false),
                    Active = table.Column<bool>(type: "bit", nullable: false),
                    CreationDate = table.Column<DateTime>(type: "datetime2", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Phones", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Phones_Costumers_CostumerId",
                        column: x => x.CostumerId,
                        principalTable: "Costumers",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "ProductsCategories",
                columns: table => new
                {
                    StoreId = table.Column<int>(type: "int", nullable: false),
                    Code = table.Column<string>(type: "nvarchar(6)", maxLength: 6, nullable: false),
                    Id = table.Column<int>(type: "int", nullable: false),
                    Name = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Description = table.Column<int>(type: "int", nullable: false),
                    ParentCategoryId = table.Column<int>(type: "int", nullable: false),
                    ParentCategoryCode = table.Column<string>(type: "nvarchar(6)", nullable: true),
                    ParentCategoryStoreId = table.Column<int>(type: "int", nullable: true),
                    Active = table.Column<bool>(type: "bit", nullable: false),
                    CreationDate = table.Column<DateTime>(type: "datetime2", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ProductsCategories", x => new { x.Code, x.StoreId });
                    table.ForeignKey(
                        name: "FK_ProductsCategories_ProductsCategories_ParentCategoryCode_ParentCategoryStoreId",
                        columns: x => new { x.ParentCategoryCode, x.ParentCategoryStoreId },
                        principalTable: "ProductsCategories",
                        principalColumns: new[] { "Code", "StoreId" });
                    table.ForeignKey(
                        name: "FK_ProductsCategories_Stores_StoreId",
                        column: x => x.StoreId,
                        principalTable: "Stores",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "Profiles",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    ProfileName = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    ProfileDescription = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    StoreId = table.Column<int>(type: "int", nullable: false),
                    Active = table.Column<bool>(type: "bit", nullable: false),
                    CreationDate = table.Column<DateTime>(type: "datetime2", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Profiles", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Profiles_Stores_StoreId",
                        column: x => x.StoreId,
                        principalTable: "Stores",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "StocksMovements",
                columns: table => new
                {
                    StoreId = table.Column<int>(type: "int", nullable: false),
                    Id = table.Column<int>(type: "int", nullable: false),
                    StockId = table.Column<int>(type: "int", nullable: false),
                    Type = table.Column<int>(type: "int", nullable: false),
                    EffectiveDate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    Quantity = table.Column<double>(type: "float", nullable: false),
                    UnityPrice = table.Column<decimal>(type: "decimal(18,2)", nullable: false),
                    OtherCosts = table.Column<decimal>(type: "decimal(18,2)", nullable: false),
                    OrderId = table.Column<int>(type: "int", nullable: false),
                    SupplierId = table.Column<int>(type: "int", nullable: false),
                    Document = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Observations = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Active = table.Column<bool>(type: "bit", nullable: false),
                    CreationDate = table.Column<DateTime>(type: "datetime2", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_StocksMovements", x => new { x.Id, x.StoreId });
                    table.ForeignKey(
                        name: "FK_StocksMovements_Stores_StoreId",
                        column: x => x.StoreId,
                        principalTable: "Stores",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "StoresProperties",
                columns: table => new
                {
                    StoreId = table.Column<int>(type: "int", nullable: false),
                    ParentId = table.Column<int>(type: "int", nullable: false),
                    Key = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    Id = table.Column<int>(type: "int", nullable: false),
                    Value = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    AllowOverride = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    ParentId1 = table.Column<int>(type: "int", nullable: false),
                    ParentKey = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    ParentStoreId = table.Column<int>(type: "int", nullable: false),
                    Active = table.Column<bool>(type: "bit", nullable: false),
                    CreationDate = table.Column<DateTime>(type: "datetime2", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_StoresProperties", x => new { x.ParentId, x.Key, x.StoreId });
                    table.ForeignKey(
                        name: "FK_StoresProperties_Stores_StoreId",
                        column: x => x.StoreId,
                        principalTable: "Stores",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_StoresProperties_StoresProperties_ParentId1_ParentKey_ParentStoreId",
                        columns: x => new { x.ParentId1, x.ParentKey, x.ParentStoreId },
                        principalTable: "StoresProperties",
                        principalColumns: new[] { "ParentId", "Key", "StoreId" });
                });

            migrationBuilder.CreateTable(
                name: "Suppliers",
                columns: table => new
                {
                    StoreId = table.Column<int>(type: "int", nullable: false),
                    Id = table.Column<int>(type: "int", nullable: false),
                    Name = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    CompanyName = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Document = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    ContactName = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    MemberSince = table.Column<DateTime>(type: "datetime2", nullable: false),
                    AddressId = table.Column<int>(type: "int", nullable: false),
                    PhoneId = table.Column<int>(type: "int", nullable: false),
                    Active = table.Column<bool>(type: "bit", nullable: false),
                    CreationDate = table.Column<DateTime>(type: "datetime2", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Suppliers", x => new { x.Id, x.StoreId });
                    table.ForeignKey(
                        name: "FK_Suppliers_Addresses_AddressId",
                        column: x => x.AddressId,
                        principalTable: "Addresses",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_Suppliers_Phones_PhoneId",
                        column: x => x.PhoneId,
                        principalTable: "Phones",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_Suppliers_Stores_StoreId",
                        column: x => x.StoreId,
                        principalTable: "Stores",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "Products",
                columns: table => new
                {
                    StoreId = table.Column<int>(type: "int", maxLength: 9, nullable: false),
                    Code = table.Column<string>(type: "nvarchar(6)", maxLength: 6, nullable: false),
                    Id = table.Column<int>(type: "int", nullable: false),
                    Name = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Display = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Description = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    SellUnity = table.Column<int>(type: "int", nullable: false),
                    Minimum = table.Column<double>(type: "float", nullable: false),
                    Tags = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Discount = table.Column<decimal>(type: "decimal(18,2)", nullable: false),
                    Price = table.Column<decimal>(type: "decimal(18,2)", nullable: false),
                    Value = table.Column<decimal>(type: "decimal(18,2)", nullable: false),
                    ComboId = table.Column<int>(type: "int", nullable: false),
                    ComboCode = table.Column<string>(type: "nvarchar(6)", nullable: false),
                    ComboStoreId = table.Column<int>(type: "int", nullable: false),
                    Type = table.Column<int>(type: "int", nullable: false),
                    ProductCategoryCode = table.Column<string>(type: "nvarchar(6)", nullable: true),
                    ProductCategoryStoreId = table.Column<int>(type: "int", nullable: true),
                    Active = table.Column<bool>(type: "bit", nullable: false),
                    CreationDate = table.Column<DateTime>(type: "datetime2", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Products", x => new { x.Code, x.StoreId });
                    table.ForeignKey(
                        name: "FK_Products_Products_ComboCode_ComboStoreId",
                        columns: x => new { x.ComboCode, x.ComboStoreId },
                        principalTable: "Products",
                        principalColumns: new[] { "Code", "StoreId" });
                    table.ForeignKey(
                        name: "FK_Products_ProductsCategories_ProductCategoryCode_ProductCategoryStoreId",
                        columns: x => new { x.ProductCategoryCode, x.ProductCategoryStoreId },
                        principalTable: "ProductsCategories",
                        principalColumns: new[] { "Code", "StoreId" });
                    table.ForeignKey(
                        name: "FK_Products_Stores_StoreId",
                        column: x => x.StoreId,
                        principalTable: "Stores",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "Operators",
                columns: table => new
                {
                    StoreId = table.Column<int>(type: "int", nullable: false),
                    Nickname = table.Column<string>(type: "nvarchar(10)", maxLength: 10, nullable: false),
                    Id = table.Column<int>(type: "int", nullable: false),
                    Name = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Password = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    MustChangePassword = table.Column<bool>(type: "bit", nullable: false),
                    ProfileId = table.Column<int>(type: "int", nullable: false),
                    Active = table.Column<bool>(type: "bit", nullable: false),
                    CreationDate = table.Column<DateTime>(type: "datetime2", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Operators", x => new { x.Nickname, x.StoreId });
                    table.ForeignKey(
                        name: "FK_Operators_Profiles_ProfileId",
                        column: x => x.ProfileId,
                        principalTable: "Profiles",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_Operators_Stores_StoreId",
                        column: x => x.StoreId,
                        principalTable: "Stores",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "ProfilesDetails",
                columns: table => new
                {
                    StoreId = table.Column<int>(type: "int", nullable: false),
                    ProfileId = table.Column<int>(type: "int", nullable: false),
                    PermissionCode = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    Id = table.Column<int>(type: "int", nullable: false),
                    AllowedToAdd = table.Column<bool>(type: "bit", nullable: false),
                    AllowedToUpdate = table.Column<bool>(type: "bit", nullable: false),
                    AllowedToDelete = table.Column<bool>(type: "bit", nullable: false),
                    AllowedToGet = table.Column<bool>(type: "bit", nullable: false),
                    Allowed = table.Column<bool>(type: "bit", nullable: false),
                    Active = table.Column<bool>(type: "bit", nullable: false),
                    CreationDate = table.Column<DateTime>(type: "datetime2", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ProfilesDetails", x => new { x.ProfileId, x.PermissionCode, x.StoreId });
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

            migrationBuilder.CreateTable(
                name: "Stocks",
                columns: table => new
                {
                    StoreId = table.Column<int>(type: "int", nullable: false),
                    ProductId = table.Column<int>(type: "int", nullable: false),
                    Id = table.Column<int>(type: "int", nullable: false),
                    Date = table.Column<DateTime>(type: "datetime2", nullable: false),
                    Minimum = table.Column<double>(type: "float", nullable: false),
                    Maximum = table.Column<double>(type: "float", nullable: false),
                    Actual = table.Column<double>(type: "float", nullable: false),
                    Location = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    StockUnity = table.Column<int>(type: "int", nullable: false),
                    MainSupplierId = table.Column<int>(type: "int", nullable: false),
                    SupplierId = table.Column<int>(type: "int", nullable: true),
                    SupplierStoreId = table.Column<int>(type: "int", nullable: true),
                    Active = table.Column<bool>(type: "bit", nullable: false),
                    CreationDate = table.Column<DateTime>(type: "datetime2", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Stocks", x => new { x.ProductId, x.StoreId });
                    table.ForeignKey(
                        name: "FK_Stocks_Stores_StoreId",
                        column: x => x.StoreId,
                        principalTable: "Stores",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_Stocks_Suppliers_SupplierId_SupplierStoreId",
                        columns: x => new { x.SupplierId, x.SupplierStoreId },
                        principalTable: "Suppliers",
                        principalColumns: new[] { "Id", "StoreId" });
                });

            migrationBuilder.CreateTable(
                name: "Ingredients",
                columns: table => new
                {
                    ProductId = table.Column<int>(type: "int", nullable: false),
                    IngredientId = table.Column<int>(type: "int", nullable: false),
                    Id = table.Column<int>(type: "int", nullable: false),
                    Quantity = table.Column<double>(type: "float", nullable: false),
                    ProductCode = table.Column<string>(type: "nvarchar(6)", nullable: true),
                    ProductStoreId = table.Column<int>(type: "int", nullable: true),
                    ComponentCode = table.Column<string>(type: "nvarchar(6)", nullable: false),
                    ComponentStoreId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Ingredients", x => new { x.ProductId, x.IngredientId });
                    table.ForeignKey(
                        name: "FK_Ingredients_Products_ComponentCode_ComponentStoreId",
                        columns: x => new { x.ComponentCode, x.ComponentStoreId },
                        principalTable: "Products",
                        principalColumns: new[] { "Code", "StoreId" });
                    table.ForeignKey(
                        name: "FK_Ingredients_Products_ProductCode_ProductStoreId",
                        columns: x => new { x.ProductCode, x.ProductStoreId },
                        principalTable: "Products",
                        principalColumns: new[] { "Code", "StoreId" });
                });

            migrationBuilder.CreateTable(
                name: "Orders",
                columns: table => new
                {
                    StoreId = table.Column<int>(type: "int", nullable: false),
                    Placed = table.Column<DateTime>(type: "datetime2", nullable: false),
                    CostumerId = table.Column<int>(type: "int", nullable: false),
                    Id = table.Column<int>(type: "int", nullable: false),
                    Status = table.Column<int>(type: "int", nullable: false),
                    PaymentMethod = table.Column<int>(type: "int", nullable: false),
                    DeliverType = table.Column<int>(type: "int", nullable: false),
                    AddressId = table.Column<int>(type: "int", maxLength: 10, nullable: false),
                    OperatorId = table.Column<int>(type: "int", nullable: false),
                    Price = table.Column<decimal>(type: "decimal(18,2)", nullable: false),
                    FinalPrice = table.Column<decimal>(type: "decimal(18,2)", nullable: false),
                    OperatorNickname = table.Column<string>(type: "nvarchar(10)", nullable: false),
                    OperatorStoreId = table.Column<int>(type: "int", nullable: false),
                    Active = table.Column<bool>(type: "bit", nullable: false),
                    CreationDate = table.Column<DateTime>(type: "datetime2", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Orders", x => new { x.Placed, x.CostumerId, x.StoreId });
                    table.ForeignKey(
                        name: "FK_Orders_Addresses_AddressId",
                        column: x => x.AddressId,
                        principalTable: "Addresses",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_Orders_Costumers_CostumerId",
                        column: x => x.CostumerId,
                        principalTable: "Costumers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_Orders_Operators_OperatorNickname_OperatorStoreId",
                        columns: x => new { x.OperatorNickname, x.OperatorStoreId },
                        principalTable: "Operators",
                        principalColumns: new[] { "Nickname", "StoreId" });
                    table.ForeignKey(
                        name: "FK_Orders_Stores_StoreId",
                        column: x => x.StoreId,
                        principalTable: "Stores",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "OrdersItems",
                columns: table => new
                {
                    StoreId = table.Column<int>(type: "int", nullable: false),
                    OrderId = table.Column<int>(type: "int", nullable: false),
                    Group = table.Column<int>(type: "int", nullable: false),
                    ProductId = table.Column<int>(type: "int", nullable: false),
                    Id = table.Column<int>(type: "int", nullable: false),
                    Quantity = table.Column<double>(type: "float", nullable: false),
                    Done = table.Column<bool>(type: "bit", nullable: false),
                    Discount = table.Column<decimal>(type: "decimal(18,2)", nullable: false),
                    Price = table.Column<decimal>(type: "decimal(18,2)", nullable: false),
                    FinalPrice = table.Column<decimal>(type: "decimal(18,2)", nullable: false),
                    ProductCode = table.Column<string>(type: "nvarchar(6)", nullable: false),
                    ProductStoreId = table.Column<int>(type: "int", nullable: false),
                    OrderPlaced = table.Column<DateTime>(type: "datetime2", nullable: false),
                    OrderCostumerId = table.Column<int>(type: "int", nullable: false),
                    OrderStoreId = table.Column<int>(type: "int", nullable: false),
                    Active = table.Column<bool>(type: "bit", nullable: false),
                    CreationDate = table.Column<DateTime>(type: "datetime2", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_OrdersItems", x => new { x.OrderId, x.Group, x.ProductId, x.StoreId });
                    table.ForeignKey(
                        name: "FK_OrdersItems_Orders_OrderPlaced_OrderCostumerId_OrderStoreId",
                        columns: x => new { x.OrderPlaced, x.OrderCostumerId, x.OrderStoreId },
                        principalTable: "Orders",
                        principalColumns: new[] { "Placed", "CostumerId", "StoreId" });
                    table.ForeignKey(
                        name: "FK_OrdersItems_Products_ProductCode_ProductStoreId",
                        columns: x => new { x.ProductCode, x.ProductStoreId },
                        principalTable: "Products",
                        principalColumns: new[] { "Code", "StoreId" });
                    table.ForeignKey(
                        name: "FK_OrdersItems_Stores_StoreId",
                        column: x => x.StoreId,
                        principalTable: "Stores",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateIndex(
                name: "IX_Addresses_CostumerId",
                table: "Addresses",
                column: "CostumerId");

            migrationBuilder.CreateIndex(
                name: "IX_Ingredients_ComponentCode_ComponentStoreId",
                table: "Ingredients",
                columns: new[] { "ComponentCode", "ComponentStoreId" });

            migrationBuilder.CreateIndex(
                name: "IX_Ingredients_ProductCode_ProductStoreId",
                table: "Ingredients",
                columns: new[] { "ProductCode", "ProductStoreId" });

            migrationBuilder.CreateIndex(
                name: "IX_Operators_ProfileId",
                table: "Operators",
                column: "ProfileId");

            migrationBuilder.CreateIndex(
                name: "IX_Operators_StoreId",
                table: "Operators",
                column: "StoreId");

            migrationBuilder.CreateIndex(
                name: "IX_Orders_AddressId",
                table: "Orders",
                column: "AddressId");

            migrationBuilder.CreateIndex(
                name: "IX_Orders_CostumerId",
                table: "Orders",
                column: "CostumerId");

            migrationBuilder.CreateIndex(
                name: "IX_Orders_OperatorNickname_OperatorStoreId",
                table: "Orders",
                columns: new[] { "OperatorNickname", "OperatorStoreId" });

            migrationBuilder.CreateIndex(
                name: "IX_Orders_StoreId",
                table: "Orders",
                column: "StoreId");

            migrationBuilder.CreateIndex(
                name: "IX_OrdersItems_OrderPlaced_OrderCostumerId_OrderStoreId",
                table: "OrdersItems",
                columns: new[] { "OrderPlaced", "OrderCostumerId", "OrderStoreId" });

            migrationBuilder.CreateIndex(
                name: "IX_OrdersItems_ProductCode_ProductStoreId",
                table: "OrdersItems",
                columns: new[] { "ProductCode", "ProductStoreId" });

            migrationBuilder.CreateIndex(
                name: "IX_OrdersItems_StoreId",
                table: "OrdersItems",
                column: "StoreId");

            migrationBuilder.CreateIndex(
                name: "IX_Phones_CostumerId",
                table: "Phones",
                column: "CostumerId");

            migrationBuilder.CreateIndex(
                name: "IX_Products_ComboCode_ComboStoreId",
                table: "Products",
                columns: new[] { "ComboCode", "ComboStoreId" });

            migrationBuilder.CreateIndex(
                name: "IX_Products_ProductCategoryCode_ProductCategoryStoreId",
                table: "Products",
                columns: new[] { "ProductCategoryCode", "ProductCategoryStoreId" });

            migrationBuilder.CreateIndex(
                name: "IX_Products_StoreId",
                table: "Products",
                column: "StoreId");

            migrationBuilder.CreateIndex(
                name: "IX_ProductsCategories_ParentCategoryCode_ParentCategoryStoreId",
                table: "ProductsCategories",
                columns: new[] { "ParentCategoryCode", "ParentCategoryStoreId" });

            migrationBuilder.CreateIndex(
                name: "IX_ProductsCategories_StoreId",
                table: "ProductsCategories",
                column: "StoreId");

            migrationBuilder.CreateIndex(
                name: "IX_Profiles_StoreId",
                table: "Profiles",
                column: "StoreId");

            migrationBuilder.CreateIndex(
                name: "IX_ProfilesDetails_StoreId",
                table: "ProfilesDetails",
                column: "StoreId");

            migrationBuilder.CreateIndex(
                name: "IX_Stocks_StoreId",
                table: "Stocks",
                column: "StoreId");

            migrationBuilder.CreateIndex(
                name: "IX_Stocks_SupplierId_SupplierStoreId",
                table: "Stocks",
                columns: new[] { "SupplierId", "SupplierStoreId" });

            migrationBuilder.CreateIndex(
                name: "IX_StocksMovements_StoreId",
                table: "StocksMovements",
                column: "StoreId");

            migrationBuilder.CreateIndex(
                name: "IX_Stores_StoreId",
                table: "Stores",
                column: "StoreId");

            migrationBuilder.CreateIndex(
                name: "IX_StoresProperties_ParentId1_ParentKey_ParentStoreId",
                table: "StoresProperties",
                columns: new[] { "ParentId1", "ParentKey", "ParentStoreId" });

            migrationBuilder.CreateIndex(
                name: "IX_StoresProperties_StoreId",
                table: "StoresProperties",
                column: "StoreId");

            migrationBuilder.CreateIndex(
                name: "IX_Suppliers_AddressId",
                table: "Suppliers",
                column: "AddressId");

            migrationBuilder.CreateIndex(
                name: "IX_Suppliers_PhoneId",
                table: "Suppliers",
                column: "PhoneId");

            migrationBuilder.CreateIndex(
                name: "IX_Suppliers_StoreId",
                table: "Suppliers",
                column: "StoreId");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Ingredients");

            migrationBuilder.DropTable(
                name: "OrdersItems");

            migrationBuilder.DropTable(
                name: "ProfilesDetails");

            migrationBuilder.DropTable(
                name: "Stocks");

            migrationBuilder.DropTable(
                name: "StocksMovements");

            migrationBuilder.DropTable(
                name: "StoresProperties");

            migrationBuilder.DropTable(
                name: "Orders");

            migrationBuilder.DropTable(
                name: "Products");

            migrationBuilder.DropTable(
                name: "Suppliers");

            migrationBuilder.DropTable(
                name: "Operators");

            migrationBuilder.DropTable(
                name: "ProductsCategories");

            migrationBuilder.DropTable(
                name: "Addresses");

            migrationBuilder.DropTable(
                name: "Phones");

            migrationBuilder.DropTable(
                name: "Profiles");

            migrationBuilder.DropTable(
                name: "Costumers");

            migrationBuilder.DropTable(
                name: "Stores");
        }
    }
}
