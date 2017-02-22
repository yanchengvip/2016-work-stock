# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170104021919) do

  create_table "2015-4-1-2016-5-25采购订单明细", id: false, force: :cascade do |t|
    t.string   "仓库名称",    limit: 255
    t.string   "标题",      limit: 255
    t.string   "采购单号",    limit: 255
    t.decimal  "采购单金额",               precision: 18, scale: 4
    t.string   "供应商名称",   limit: 255
    t.decimal  "采购单抵扣金额",             precision: 18, scale: 4
    t.datetime "时间"
    t.string   "二级分类",    limit: 255
    t.string   "三级分类",    limit: 255
    t.string   "商品编号",    limit: 100,                          default: "",   null: false
    t.string   "商品名称",    limit: 100,                                         null: false
    t.string   "规格",      limit: 255
    t.integer  "订货数量",    limit: 4
    t.integer  "实收数量",    limit: 4,                                           null: false
    t.decimal  "定货价",                 precision: 18, scale: 4
    t.decimal  "商品总价",                precision: 28, scale: 4
    t.decimal  "税点",                  precision: 18, scale: 2, default: 0.17
    t.decimal  "移动加权平均数",             precision: 18, scale: 4
  end

  create_table "2016-1-1-2016-6-30采购单", id: false, force: :cascade do |t|
    t.string   "采购申请单号", limit: 255
    t.string   "仓库",     limit: 255
    t.string   "标题",     limit: 255
    t.datetime "预计发货时间"
    t.string   "付款方式",   limit: 4
    t.decimal  "采购单总价",                     precision: 18, scale: 4
    t.decimal  "实际含税金额",                    precision: 50, scale: 4
    t.text     "备注",     limit: 4294967295
    t.datetime "确认付款时间"
    t.text     "审核信息",   limit: 4294967295
    t.string   "收货状态",   limit: 5
    t.string   "状态",     limit: 3,                                   default: "", null: false
    t.string   "是否有发票",  limit: 1
    t.string   "发票号",    limit: 255
    t.string   "仓库联系人",  limit: 255
    t.string   "联系人电话",  limit: 255
    t.string   "公司名称",   limit: 100
    t.datetime "创建时间"
    t.string   "是否代销",   limit: 1
    t.string   "供应商名称",  limit: 255
  end

  create_table "5月大卫之选订单商品", id: false, force: :cascade do |t|
    t.string  "OrderCode",    limit: 255
    t.string  "SaleName",     limit: 255
    t.string  "Name",         limit: 100,                                      null: false
    t.integer "Quantity",     limit: 4,                                        null: false
    t.string  "Unit",         limit: 255
    t.integer "OOSNumber",    limit: 4,                            default: 0
    t.integer "RetrunNumber", limit: 4
    t.decimal "Price",                    precision: 18, scale: 2
  end

  create_table "__migrationhistory", id: false, force: :cascade do |t|
    t.string "MigrationId",    limit: 100,        null: false
    t.string "ContextKey",     limit: 200,        null: false
    t.binary "Model",          limit: 4294967295, null: false
    t.string "ProductVersion", limit: 32,         null: false
  end

  create_table "actionlogmlcontents", primary_key: "ID", force: :cascade do |t|
    t.string "ModuleName",   limit: 50
    t.string "ActionName",   limit: 50
    t.text   "LanguageCode", limit: 4294967295
    t.string "MLParentID",   limit: 36,         default: "", null: false
  end

  add_index "actionlogmlcontents", ["MLParentID"], name: "IX_MLParentID", using: :btree

  create_table "actionlogmlcontents_0517", primary_key: "ID", force: :cascade do |t|
    t.string "ModuleName",   limit: 50
    t.string "ActionName",   limit: 50
    t.text   "LanguageCode", limit: 4294967295
    t.string "MLParentID",   limit: 36,         default: "", null: false
  end

  add_index "actionlogmlcontents_0517", ["MLParentID"], name: "IX_MLParentID", using: :btree

  create_table "actionlogmlcontents_0802", primary_key: "ID", force: :cascade do |t|
    t.string "ModuleName",   limit: 50
    t.string "ActionName",   limit: 50
    t.text   "LanguageCode", limit: 4294967295
    t.string "MLParentID",   limit: 36,         default: "", null: false
  end

  add_index "actionlogmlcontents_0802", ["MLParentID"], name: "IX_MLParentID", using: :btree

  create_table "actionlogs", primary_key: "ID", force: :cascade do |t|
    t.string   "ITCode",     limit: 100
    t.string   "ActionUrl",  limit: 255
    t.datetime "ActionTime",                    null: false
    t.float    "Duration",   limit: 53,         null: false
    t.text     "Remark",     limit: 4294967295
    t.string   "IP",         limit: 50
    t.integer  "LogType",    limit: 4,          null: false
    t.datetime "CreateTime"
    t.string   "CreateBy",   limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",   limit: 100
  end

  create_table "actionlogs_0517", primary_key: "ID", force: :cascade do |t|
    t.string   "ITCode",     limit: 100
    t.string   "ActionUrl",  limit: 255
    t.datetime "ActionTime",                    null: false
    t.float    "Duration",   limit: 53,         null: false
    t.text     "Remark",     limit: 4294967295
    t.string   "IP",         limit: 50
    t.integer  "LogType",    limit: 4,          null: false
    t.datetime "CreateTime"
    t.string   "CreateBy",   limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",   limit: 100
  end

  create_table "actionlogs_0802", primary_key: "ID", force: :cascade do |t|
    t.string   "ITCode",     limit: 100
    t.string   "ActionUrl",  limit: 255
    t.datetime "ActionTime",                    null: false
    t.float    "Duration",   limit: 53,         null: false
    t.text     "Remark",     limit: 4294967295
    t.string   "IP",         limit: 50
    t.integer  "LogType",    limit: 4,          null: false
    t.datetime "CreateTime"
    t.string   "CreateBy",   limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",   limit: 100
  end

  create_table "activities", primary_key: "ID", force: :cascade do |t|
    t.string   "Title",           limit: 255
    t.decimal  "ActivityPrice",               precision: 18, scale: 2
    t.integer  "Type",            limit: 8
    t.datetime "BeginDate"
    t.datetime "EndDate"
    t.decimal  "GiftCouponPrice",             precision: 18, scale: 2
    t.integer  "GiftCouponDays",  limit: 4
    t.decimal  "Discount",                    precision: 18, scale: 2
    t.decimal  "SubPrice",                    precision: 18, scale: 2
    t.integer  "Status",          limit: 8
    t.string   "Remark",          limit: 255
    t.datetime "CreateTime"
    t.string   "CreateBy",        limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",        limit: 100
    t.string   "ActivityPurpose", limit: 255
    t.string   "CompanyID",       limit: 36
    t.integer  "ThirdType",       limit: 4
    t.string   "CityID",          limit: 36
  end

  create_table "activity_floor_products", primary_key: "ID", force: :cascade do |t|
    t.string   "ActivityFloorID", limit: 36,  default: "", null: false
    t.string   "ProductID",       limit: 36,  default: "", null: false
    t.integer  "Sort",            limit: 4
    t.datetime "CreateTime"
    t.string   "CreateBy",        limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",        limit: 100
    t.string   "ProductName",     limit: 100
    t.string   "ProductCode",     limit: 100
    t.string   "ProductGroup",    limit: 100
    t.string   "Unit",            limit: 100
    t.string   "Brand",           limit: 100
    t.string   "State",           limit: 100
  end

  add_index "activity_floor_products", ["ActivityFloorID"], name: "IX_ActivityFloorID", using: :btree
  add_index "activity_floor_products", ["ProductID"], name: "IX_ProductID", using: :btree

  create_table "activity_floors", primary_key: "ID", force: :cascade do |t|
    t.string   "FloorName",                limit: 255, default: "", null: false
    t.string   "ShowName",                 limit: 255, default: "", null: false
    t.integer  "Sort",                     limit: 4
    t.string   "Picture",                  limit: 255
    t.string   "PictureQiNiu",             limit: 255
    t.integer  "Pattern",                  limit: 4
    t.string   "ProductRecommendInfoID",   limit: 36
    t.string   "ParentProductRecommendID", limit: 36
    t.string   "CompanyID",                limit: 36
    t.datetime "CreateTime"
    t.string   "CreateBy",                 limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",                 limit: 100
  end

  create_table "activitylogs", primary_key: "ID", force: :cascade do |t|
    t.string   "ActivityID", limit: 36
    t.integer  "Status",     limit: 8
    t.string   "Operation",  limit: 255
    t.string   "Remark",     limit: 255
    t.string   "IP",         limit: 255
    t.string   "Agent",      limit: 255
    t.datetime "CreateTime"
    t.string   "CreateBy",   limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",   limit: 100
  end

  create_table "activityorders", primary_key: "ID", force: :cascade do |t|
    t.string   "ActivityID", limit: 36
    t.string   "OrderID",    limit: 36
    t.datetime "CreateTime"
    t.string   "CreateBy",   limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",   limit: 100
  end

  create_table "activityproducts", primary_key: "ID", force: :cascade do |t|
    t.string   "ActivityID",  limit: 36
    t.string   "ProductID",   limit: 36
    t.string   "ProductCode", limit: 255
    t.string   "ProductName", limit: 255
    t.integer  "GiftNumber",  limit: 4
    t.datetime "CreateTime"
    t.string   "CreateBy",    limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",    limit: 100
  end

  create_table "advertisepicgroups", primary_key: "ID", force: :cascade do |t|
    t.integer  "AdvertGID",  limit: 4,   null: false
    t.string   "Name",       limit: 255
    t.string   "Describe",   limit: 255
    t.datetime "CreateTime"
    t.string   "CreateBy",   limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",   limit: 100
  end

  create_table "advertisepics", primary_key: "ID", force: :cascade do |t|
    t.integer  "AdvertID",                 limit: 4,   null: false
    t.string   "Name",                     limit: 255
    t.string   "Src",                      limit: 255
    t.string   "Href",                     limit: 255
    t.string   "Describe",                 limit: 255
    t.integer  "OrderBy",                  limit: 4
    t.integer  "ImgG",                     limit: 4
    t.string   "AdvertisePicGroupID",      limit: 36
    t.string   "PhotoID",                  limit: 36
    t.datetime "CreateTime"
    t.string   "CreateBy",                 limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",                 limit: 100
    t.string   "FileQiniuName",            limit: 255
    t.string   "ProductRecommendInfoesID", limit: 36
    t.boolean  "IsEnabled",                limit: 1
    t.string   "CompanyID",                limit: 36
  end

  add_index "advertisepics", ["AdvertisePicGroupID"], name: "IX_AdvertisePicGroupID", using: :btree
  add_index "advertisepics", ["PhotoID"], name: "IX_PhotoID", using: :btree

  create_table "appversions", primary_key: "ID", force: :cascade do |t|
    t.string   "Version",       limit: 255
    t.text     "Content",       limit: 4294967295
    t.string   "Url",           limit: 255
    t.string   "Platform",      limit: 255
    t.boolean  "Force",         limit: 1
    t.string   "MinOldVersion", limit: 255
    t.boolean  "Enable",        limit: 1
    t.datetime "CreateTime"
    t.string   "CreateBy",      limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",      limit: 100
  end

  create_table "areaview", id: false, force: :cascade do |t|
    t.string "ProvinceID",   limit: 36,  default: "", null: false
    t.string "ProvinceName", limit: 255,              null: false
    t.string "CityID",       limit: 36,  default: "", null: false
    t.string "CityName",     limit: 255,              null: false
    t.string "CountyID",     limit: 36,  default: "", null: false
    t.string "CountyName",   limit: 255,              null: false
  end

  create_table "auditfreeconditions", primary_key: "ID", force: :cascade do |t|
    t.text     "Condition",           limit: 4294967295
    t.string   "PurchaseAuditFreeID", limit: 36
    t.decimal  "parameter",                              precision: 18, scale: 2
    t.string   "ProductGroupID",      limit: 36
    t.integer  "Relationship",        limit: 4
    t.integer  "Examine",             limit: 4
    t.datetime "CreateTime"
    t.string   "CreateBy",            limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",            limit: 100
    t.string   "ParentID",            limit: 36
    t.string   "CompanyID",           limit: 36
  end

  add_index "auditfreeconditions", ["ProductGroupID"], name: "IX_ProductGroupID", using: :btree
  add_index "auditfreeconditions", ["PurchaseAuditFreeID"], name: "IX_PurchaseAuditFreeID", using: :btree

  create_table "autoreplenishstocklogs", primary_key: "ID", force: :cascade do |t|
    t.string   "DepotID",           limit: 36
    t.string   "ProductID",         limit: 36
    t.string   "ErrorSubProductID", limit: 36
    t.integer  "OldStockNumber",    limit: 4
    t.integer  "ChangeStockNumber", limit: 4
    t.binary   "IsSuccess",         limit: 1
    t.text     "Message",           limit: 65535
    t.datetime "CreateTime"
    t.string   "CreateBy",          limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",          limit: 100
  end

  create_table "bankinfoes", primary_key: "ID", force: :cascade do |t|
    t.integer  "IDs",        limit: 8,               null: false
    t.string   "Name",       limit: 255,             null: false
    t.integer  "DataLevel",  limit: 1,               null: false
    t.integer  "ParentIDs",  limit: 8,               null: false
    t.string   "ParentID",   limit: 36
    t.datetime "CreateTime"
    t.string   "CreateBy",   limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",   limit: 100
    t.integer  "Sort",       limit: 4,   default: 0
  end

  create_table "banners", primary_key: "ID", force: :cascade do |t|
    t.string   "PicQiNiu",               limit: 36
    t.string   "Pic",                    limit: 36
    t.datetime "StartDate"
    t.datetime "EndDate"
    t.boolean  "IsEnable",               limit: 1
    t.string   "ProductrecommendinfoID", limit: 36
    t.string   "CreateBy",               limit: 100
    t.datetime "CreateTime"
    t.datetime "UpdateTime"
    t.string   "UpdateBy",               limit: 100
    t.string   "Title",                  limit: 255
    t.integer  "TerminalType",           limit: 4
    t.string   "CompanyID",              limit: 36
  end

  create_table "barcode_histories", primary_key: "ID", force: :cascade do |t|
    t.string   "UserID",     limit: 36
    t.string   "Code",       limit: 255
    t.string   "CreateBy",   limit: 255
    t.string   "UpdateBy",   limit: 255
    t.datetime "CreateTime"
    t.datetime "UpdateTime"
    t.boolean  "IsDeleted",  limit: 1,   default: false
  end

  create_table "batch_product_price_logs", primary_key: "ID", force: :cascade do |t|
    t.string   "BatchProductPriceID", limit: 36
    t.integer  "Status",              limit: 4
    t.string   "Remark",              limit: 255
    t.string   "IP",                  limit: 255
    t.string   "Agent",               limit: 255
    t.datetime "CreateTime"
    t.string   "CreateBy",            limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",            limit: 100
  end

  create_table "batch_product_prices", primary_key: "ID", force: :cascade do |t|
    t.string   "Remark",     limit: 100
    t.string   "Title",      limit: 255
    t.datetime "CreateTime"
    t.string   "CreateBy",   limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",   limit: 100
    t.integer  "Status",     limit: 4
  end

  create_table "car_types", primary_key: "ID", force: :cascade do |t|
    t.string   "TypeName",   limit: 255
    t.datetime "CreateTime"
    t.string   "CreateBy",   limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",   limit: 100
  end

  create_table "carts", primary_key: "ID", force: :cascade do |t|
    t.integer  "Number",     limit: 4,                  null: false
    t.datetime "CreateTime"
    t.string   "CreateBy",   limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",   limit: 100
    t.string   "ProductID",  limit: 36
    t.string   "UserID",     limit: 36
    t.boolean  "is_checked", limit: 1,   default: true
    t.string   "CompanyID",  limit: 255
    t.integer  "ThirdType",  limit: 4,   default: 0
  end

  add_index "carts", ["ProductID"], name: "IX_ProductID", using: :btree
  add_index "carts", ["UserID", "ProductID"], name: "UQ_UserID_ProductID", unique: true, using: :btree
  add_index "carts", ["UserID"], name: "IX_UserID", using: :btree

  create_table "cash_volume_histories", primary_key: "ID", force: :cascade do |t|
    t.string   "UserID",          limit: 36
    t.decimal  "CurrentCash",                 precision: 11, scale: 2, null: false
    t.decimal  "DeltaCash",                   precision: 11, scale: 2, null: false
    t.integer  "Type",            limit: 4,                            null: false
    t.datetime "CreateTime"
    t.string   "CreateBy",        limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",        limit: 100
    t.string   "OrderID",         limit: 36
    t.string   "UserCashBatchID", limit: 36
  end

  add_index "cash_volume_histories", ["OrderID"], name: "index_cash_volume_histories_on_OrderID", using: :btree
  add_index "cash_volume_histories", ["UserCashBatchID"], name: "index_cash_volume_histories_on_UserCashBatchID", using: :btree
  add_index "cash_volume_histories", ["UserID"], name: "index_cash_volume_histories_on_UserID", using: :btree

  create_table "cash_volume_histories_copy", primary_key: "ID", force: :cascade do |t|
    t.string   "UserID",          limit: 36
    t.decimal  "CurrentCash",                 precision: 11, scale: 2, null: false
    t.decimal  "DeltaCash",                   precision: 11, scale: 2, null: false
    t.integer  "Type",            limit: 4,                            null: false
    t.datetime "CreateTime"
    t.string   "CreateBy",        limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",        limit: 100
    t.string   "OrderID",         limit: 36
    t.string   "UserCashBatchID", limit: 36
  end

  add_index "cash_volume_histories_copy", ["OrderID"], name: "index_cash_volume_histories_on_OrderID", using: :btree
  add_index "cash_volume_histories_copy", ["UserCashBatchID"], name: "index_cash_volume_histories_on_UserCashBatchID", using: :btree
  add_index "cash_volume_histories_copy", ["UserID"], name: "index_cash_volume_histories_on_UserID", using: :btree

  create_table "checkins", id: false, force: :cascade do |t|
    t.string   "ID",          limit: 36, null: false
    t.string   "UserID",      limit: 36
    t.date     "CheckInDate"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "checkins", ["UserID", "CheckInDate"], name: "index_CheckIns_on_UserID_and_CheckInDate", unique: true, using: :btree
  add_index "checkins", ["UserID"], name: "index_CheckIns_on_UserID", using: :btree

  create_table "checkstockdetails", primary_key: "ID", force: :cascade do |t|
    t.string   "BatchID",           limit: 36
    t.string   "ProductID",         limit: 36
    t.string   "ProductName",       limit: 255
    t.string   "ProductCode",       limit: 255
    t.integer  "Stock",             limit: 4
    t.decimal  "ProductPrice",                  precision: 18, scale: 4
    t.integer  "CheckNumber",       limit: 4
    t.integer  "OrderStock",        limit: 4
    t.datetime "CreateTime"
    t.string   "CreateBy",          limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",          limit: 100
    t.integer  "PrintOrderCount",   limit: 4
    t.integer  "RealStock",         limit: 4
    t.string   "DepotShelfID",      limit: 36
    t.string   "DepotSheflBarCode", limit: 255
    t.string   "DepotTrayID",       limit: 36
    t.string   "DepotTrayBarCode",  limit: 255
    t.datetime "ExpirationDate"
    t.binary   "IsCheckStop",       limit: 1
    t.integer  "RealStack",         limit: 4
    t.decimal  "AvgPurchasePrice",              precision: 18, scale: 2, default: 0.0
  end

  add_index "checkstockdetails", ["BatchID"], name: "IDX_BATCHID", using: :btree

  create_table "checkstocks", id: false, force: :cascade do |t|
    t.string   "ID",             limit: 36,  null: false
    t.string   "CheckStockCode", limit: 255
    t.string   "DepotShelfID",   limit: 36
    t.string   "DepotID",        limit: 36
    t.string   "DepotName",      limit: 255
    t.integer  "CheckType",      limit: 4
    t.integer  "CheckState",     limit: 4,   null: false
    t.datetime "CreateTime"
    t.string   "CreateBy",       limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",       limit: 100
    t.datetime "EndTime"
  end

  add_index "checkstocks", ["ID"], name: "IDX_ID", using: :btree

  create_table "cities", primary_key: "ID", force: :cascade do |t|
    t.string   "CityCode",   limit: 255,                 null: false
    t.string   "CityName",   limit: 255,                 null: false
    t.string   "ProvinceID", limit: 36
    t.datetime "CreateTime"
    t.string   "CreateBy",   limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",   limit: 100
    t.string   "CompanyID",  limit: 36
    t.boolean  "IsEnabled",  limit: 1,   default: false
  end

  add_index "cities", ["ProvinceID"], name: "IX_ProvinceID", using: :btree

  create_table "cmborder", primary_key: "Id", force: :cascade do |t|
    t.string   "PNo",        limit: 32,                          null: false
    t.string   "OrderCode",  limit: 32,                          null: false
    t.string   "Random",     limit: 32,                          null: false
    t.string   "BillNo",     limit: 32,                          null: false
    t.decimal  "PayMoney",              precision: 10, scale: 2, null: false
    t.integer  "PayStatus",  limit: 1,                           null: false
    t.datetime "CreateTime",                                     null: false
    t.datetime "Updatetime",                                     null: false
  end

  add_index "cmborder", ["BillNo"], name: "idx_CMBOrder_BillNo", using: :btree
  add_index "cmborder", ["OrderCode"], name: "idx_CMBOrder_OrderCode", using: :btree
  add_index "cmborder", ["PNo"], name: "idx_CMBOrder_PNo", using: :btree

  create_table "company_cities", primary_key: "ID", force: :cascade do |t|
    t.string   "CompanyID",  limit: 36
    t.string   "CityID",     limit: 36
    t.string   "CityName",   limit: 255
    t.integer  "SendPrice",  limit: 4,   default: 0
    t.datetime "CreateTime"
    t.string   "CreateBy",   limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",   limit: 100
    t.integer  "SkuCount",   limit: 4,   default: 0
  end

  create_table "companyphotoes", primary_key: "ID", force: :cascade do |t|
    t.string   "PhotoID",    limit: 36
    t.text     "Remark",     limit: 4294967295
    t.string   "CompanyID",  limit: 36,         default: "", null: false
    t.datetime "CreateTime"
    t.string   "CreateBy",   limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",   limit: 100
  end

  add_index "companyphotoes", ["CompanyID"], name: "IX_CompanyID", using: :btree
  add_index "companyphotoes", ["PhotoID"], name: "IX_PhotoID", using: :btree

  create_table "companyproductgroups", primary_key: "ID", force: :cascade do |t|
    t.string   "CompanyID",            limit: 36
    t.string   "ProductGroupID",       limit: 36
    t.boolean  "IsEnable",             limit: 1,   null: false
    t.string   "CityID",               limit: 36
    t.datetime "CreateTime"
    t.string   "CreateBy",             limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",             limit: 100
    t.string   "FrameworkCompanys_ID", limit: 36
  end

  add_index "companyproductgroups", ["CityID"], name: "IX_CityID", using: :btree
  add_index "companyproductgroups", ["FrameworkCompanys_ID"], name: "IX_FrameworkCompanys_ID", using: :btree
  add_index "companyproductgroups", ["ProductGroupID"], name: "IX_ProductGroupID", using: :btree

  create_table "companysalestargets", primary_key: "ID", force: :cascade do |t|
    t.string   "CompanyID",   limit: 36
    t.decimal  "SalesTarget",             precision: 18, scale: 2
    t.datetime "CreateTime"
    t.string   "CreateBy",    limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",    limit: 100
  end

  add_index "companysalestargets", ["CompanyID"], name: "IX_CompanyID", using: :btree

  create_table "contractapproves", primary_key: "ID", force: :cascade do |t|
    t.text     "TitleTitleTitleTitleTitleTitleTitle", limit: 4294967295
    t.text     "Content",                             limit: 4294967295
    t.text     "Approver",                            limit: 4294967295
    t.string   "CompanyID",                           limit: 36,         default: "", null: false
    t.string   "DepartmentID",                        limit: 36
    t.datetime "CreateTime"
    t.string   "CreateBy",                            limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",                            limit: 100
  end

  add_index "contractapproves", ["CompanyID"], name: "IX_CompanyID", using: :btree
  add_index "contractapproves", ["DepartmentID"], name: "IX_DepartmentID", using: :btree

  create_table "counties", primary_key: "ID", force: :cascade do |t|
    t.string   "CountyName", limit: 255, null: false
    t.string   "CountyCode", limit: 255, null: false
    t.string   "CityID",     limit: 36
    t.datetime "CreateTime"
    t.string   "CreateBy",   limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",   limit: 100
    t.string   "CompanyID",  limit: 36
  end

  add_index "counties", ["CityID"], name: "IX_CityID", using: :btree

  create_table "coupon_batch_logs", primary_key: "ID", force: :cascade do |t|
    t.string   "Coupon_BatchID", limit: 36
    t.integer  "Status",         limit: 4
    t.text     "Remark",         limit: 4294967295
    t.string   "IP",             limit: 255
    t.string   "Agent",          limit: 255
    t.datetime "CreateTime"
    t.string   "CreateBy",       limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",       limit: 100
  end

  create_table "coupon_batch_users", primary_key: "ID", force: :cascade do |t|
    t.string   "CouponID",        limit: 36
    t.string   "Coupon_Batch_ID", limit: 36
    t.string   "UserID",          limit: 36
    t.datetime "CreateTime"
    t.string   "CreateBy",        limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",        limit: 100
    t.string   "Phone",           limit: 255
  end

  create_table "coupon_batches", primary_key: "ID", force: :cascade do |t|
    t.string   "CouponID",   limit: 36
    t.integer  "Status",     limit: 4
    t.string   "Cause",      limit: 255
    t.string   "OrderCode",  limit: 255
    t.datetime "CreateTime"
    t.string   "CreateBy",   limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",   limit: 100
    t.datetime "SubmitTime"
  end

  create_table "coupon_logs", primary_key: "ID", force: :cascade do |t|
    t.string   "CouponID",   limit: 36
    t.integer  "Status",     limit: 4
    t.text     "Remark",     limit: 4294967295
    t.string   "IP",         limit: 255
    t.string   "Agent",      limit: 255
    t.datetime "CreateTime"
    t.string   "CreateBy",   limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",   limit: 100
  end

  create_table "coupon_productbrands", primary_key: "ID", force: :cascade do |t|
    t.string   "CouponID",         limit: 36
    t.string   "ProductBrandID",   limit: 36
    t.string   "ProductBrandName", limit: 255
    t.datetime "CreateTime"
    t.string   "CreateBy",         limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",         limit: 100
  end

  create_table "coupon_productgroups", primary_key: "ID", force: :cascade do |t|
    t.string   "CouponID",         limit: 36
    t.string   "ProductGroupID",   limit: 36
    t.string   "ProductGroupName", limit: 255
    t.datetime "CreateTime"
    t.string   "CreateBy",         limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",         limit: 100
  end

  create_table "coupon_products", primary_key: "ID", force: :cascade do |t|
    t.string   "CouponID",         limit: 36
    t.string   "ProductID",        limit: 36
    t.string   "ProductName",      limit: 255
    t.string   "ProductCode",      limit: 255
    t.datetime "CreateTime"
    t.string   "CreateBy",         limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",         limit: 100
    t.string   "Specification",    limit: 255
    t.string   "Unit",             limit: 255
    t.string   "ProductBrandName", limit: 255
    t.decimal  "ProductPrice",                 precision: 8, scale: 2
    t.string   "ProductGroupName", limit: 255
  end

  create_table "coupon_users", primary_key: "ID", force: :cascade do |t|
    t.string   "CouponID",   limit: 36
    t.string   "Phone",      limit: 255
    t.string   "UserID",     limit: 36
    t.datetime "CreateTime"
    t.string   "CreateBy",   limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",   limit: 100
  end

  create_table "couponapplies", primary_key: "ID", force: :cascade do |t|
    t.string   "Title",        limit: 255
    t.integer  "Status",       limit: 4
    t.datetime "EndDate"
    t.decimal  "Price",                    precision: 18, scale: 2
    t.string   "Cause",        limit: 255
    t.datetime "StartDate"
    t.integer  "UseMoney",     limit: 4,                            default: 0
    t.datetime "CreateTime"
    t.string   "CreateBy",     limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",     limit: 100
    t.integer  "CouponAmount", limit: 4,                            default: 0
    t.string   "OrderCode",    limit: 255
  end

  create_table "couponapplylogs", primary_key: "ID", force: :cascade do |t|
    t.string   "CouponAppliesID", limit: 36
    t.integer  "LogType",         limit: 4
    t.string   "Remark",          limit: 255
    t.datetime "CreateTime"
    t.string   "CreateBy",        limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",        limit: 100
    t.string   "IP",              limit: 255
    t.string   "Agent",           limit: 255
  end

  create_table "couponpayments", primary_key: "ID", force: :cascade do |t|
    t.string   "CompanyID",     limit: 36
    t.string   "Province",      limit: 255
    t.string   "UserID",        limit: 36
    t.string   "Address",       limit: 255
    t.decimal  "ReceivedPrice",             precision: 18, scale: 4
    t.integer  "ShouldCount",   limit: 4
    t.integer  "SendCount",     limit: 4
    t.datetime "CreateTime"
    t.string   "CreateBy",      limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",      limit: 100
  end

  add_index "couponpayments", ["UserID"], name: "UserID", unique: true, using: :btree

  create_table "coupons", primary_key: "ID", force: :cascade do |t|
    t.string   "Title",                  limit: 255
    t.string   "SubTitle",               limit: 255
    t.integer  "CouponType",             limit: 4
    t.string   "CompanyID",              limit: 36
    t.integer  "ActivityPrice",          limit: 4
    t.string   "Logo",                   limit: 36
    t.string   "LogoQiNiu",              limit: 36
    t.datetime "BeginTime"
    t.datetime "EndTime"
    t.decimal  "CouponPrice",                        precision: 18, scale: 2
    t.integer  "CouponDays",             limit: 4
    t.string   "ProductRecommendInfoID", limit: 36
    t.integer  "CouponCount",            limit: 4,                                        null: false
    t.integer  "CurrentCount",           limit: 4,                            default: 0, null: false
    t.datetime "CreateTime"
    t.string   "CreateBy",               limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",               limit: 100
    t.integer  "Usage",                  limit: 4
    t.integer  "Status",                 limit: 4
    t.decimal  "CouponDiscount",                     precision: 4,  scale: 2
    t.integer  "MaxPrice",               limit: 4
    t.integer  "CouponStatus",           limit: 4,                            default: 1
    t.integer  "SendModel",              limit: 4
    t.string   "Remark",                 limit: 255
  end

  create_table "couponsaregivenouts", primary_key: "ID", force: :cascade do |t|
    t.string   "UserID",          limit: 36,  null: false
    t.string   "UserCouponID",    limit: 36,  null: false
    t.string   "StatisticsMonth", limit: 255, null: false
    t.datetime "CreateTime"
    t.string   "CreateBy",        limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",        limit: 100
  end

  create_table "createusercountbydates", id: false, force: :cascade do |t|
    t.string  "CreateTime", limit: 10
    t.string  "CompanyID",  limit: 36
    t.integer "TotalUser",  limit: 8,  default: 0, null: false
  end

  create_table "dataprivileges", primary_key: "ID", force: :cascade do |t|
    t.string   "UserID",     limit: 36,  default: "", null: false
    t.string   "TableName",  limit: 50,               null: false
    t.string   "RelateID",   limit: 36
    t.string   "DomainID",   limit: 36
    t.datetime "CreateTime"
    t.string   "CreateBy",   limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",   limit: 100
  end

  add_index "dataprivileges", ["DomainID"], name: "IX_DomainID", using: :btree

  create_table "days", id: false, force: :cascade do |t|
    t.string "QueryDate", limit: 10
  end

  create_table "daysummarylists", id: false, force: :cascade do |t|
    t.string  "QueryDate",              limit: 24
    t.string  "DepotId",                limit: 36
    t.string  "CompanyID",              limit: 36
    t.decimal "TotalOrder",                        precision: 42,           default: 0,   null: false
    t.decimal "OrderProductTotalPrice",            precision: 65, scale: 2, default: 0.0, null: false
    t.decimal "GiveawayTotalPrice",                precision: 40, scale: 2, default: 0.0, null: false
    t.decimal "CouponTotalPrice",                  precision: 40, scale: 2, default: 0.0, null: false
    t.decimal "PointTotalPrice",                   precision: 40, scale: 2, default: 0.0, null: false
    t.decimal "LogiTotalPrice",                    precision: 40, scale: 2, default: 0.0, null: false
    t.decimal "TotalMoney",                        precision: 40, scale: 2, default: 0.0, null: false
    t.decimal "TotalReceivedPrice",                precision: 40, scale: 2, default: 0.0, null: false
    t.decimal "TotalOnlinePayDiscount",            precision: 40, scale: 2, default: 0.0, null: false
  end

  create_table "depotemployees", primary_key: "ID", force: :cascade do |t|
    t.string   "DepotID",      limit: 36
    t.string   "EmployeeName", limit: 255
    t.string   "Position",     limit: 255
    t.string   "Phone",        limit: 255
    t.string   "Mobile",       limit: 255
    t.string   "Remark",       limit: 255
    t.datetime "CreateTime"
    t.string   "CreateBy",     limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",     limit: 100
  end

  add_index "depotemployees", ["DepotID"], name: "IX_DepotID", using: :btree

  create_table "depotlogs", primary_key: "ID", force: :cascade do |t|
    t.string   "DepotID",    limit: 36
    t.string   "Remark",     limit: 255
    t.datetime "CreateTime"
    t.string   "CreateBy",   limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",   limit: 100
  end

  create_table "depotproductdamagestocks", primary_key: "ID", force: :cascade do |t|
    t.string   "DepotID",          limit: 36,                           default: ""
    t.string   "ProductID",        limit: 36,                           default: ""
    t.string   "ProductCode",      limit: 255
    t.integer  "Stock",            limit: 4
    t.datetime "CreateTime"
    t.string   "CreateBy",         limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",         limit: 100
    t.integer  "Status",           limit: 4
    t.string   "OrderID",          limit: 36
    t.string   "OrderCode",        limit: 255
    t.integer  "ToBeConfirmed",    limit: 4
    t.integer  "InStorage",        limit: 4
    t.integer  "Damage",           limit: 4
    t.integer  "DamageSource",     limit: 4
    t.string   "DutyPerson",       limit: 255
    t.string   "DepotShelfID",     limit: 36
    t.string   "DepotTrayID",      limit: 36
    t.datetime "ExpirationDate"
    t.decimal  "AvgPurchasePrice",             precision: 18, scale: 4, default: 0.0
    t.string   "GeneralID",        limit: 36
  end

  create_table "depotproductdamagestockslogs", primary_key: "ID", force: :cascade do |t|
    t.string   "DepotID",        limit: 36,  default: ""
    t.string   "ProductID",      limit: 36,  default: ""
    t.string   "ProductCode",    limit: 255
    t.integer  "Stock",          limit: 4
    t.datetime "CreateTime"
    t.string   "CreateBy",       limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",       limit: 100
    t.integer  "Status",         limit: 4
    t.string   "OrderID",        limit: 36
    t.string   "OrderCode",      limit: 255
    t.integer  "ToBeConfirmed",  limit: 4
    t.integer  "InStorage",      limit: 4
    t.integer  "Damage",         limit: 4
    t.string   "DamageID",       limit: 36
    t.string   "IP",             limit: 255
    t.integer  "DamageSource",   limit: 4
    t.string   "DutyPerson",     limit: 255
    t.string   "DepotShelfID",   limit: 36
    t.string   "DepotTrayID",    limit: 36
    t.datetime "ExpirationDate"
  end

  create_table "depotproductstockbackupbymonth", id: false, force: :cascade do |t|
    t.string  "ID",                  limit: 36,                           default: "",  null: false
    t.string  "DepotProductStockID", limit: 36,                                         null: false
    t.string  "DepotID",             limit: 36,                           default: "",  null: false
    t.string  "ProductID",           limit: 36,                           default: "",  null: false
    t.string  "ProductCode",         limit: 255
    t.integer "Stock",               limit: 4,                            default: 0,   null: false
    t.integer "RealStock",           limit: 4,                            default: 0,   null: false
    t.decimal "BeforePurchasePrice",             precision: 10, scale: 2, default: 0.0, null: false
    t.integer "State",               limit: 4
    t.date    "BakDate"
  end

  add_index "depotproductstockbackupbymonth", ["DepotID"], name: "IX_DepotID", using: :btree
  add_index "depotproductstockbackupbymonth", ["ProductID"], name: "IX_ProductID", using: :btree

  create_table "depotproductstocks", primary_key: "ID", force: :cascade do |t|
    t.string   "DepotID",             limit: 36,                           default: "", null: false
    t.string   "ProductID",           limit: 36,                           default: "", null: false
    t.string   "ProductCode",         limit: 255
    t.integer  "Stock",               limit: 4,                                         null: false
    t.datetime "CreateTime"
    t.string   "CreateBy",            limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",            limit: 100
    t.integer  "DamageStock",         limit: 4
    t.string   "DutyPerson",          limit: 255
    t.string   "DepotName",           limit: 255
    t.integer  "AddStock",            limit: 4
    t.integer  "SubtractStock",       limit: 4
    t.decimal  "BeforePurchasePrice",             precision: 10, scale: 4
    t.integer  "State",               limit: 4
    t.integer  "RealStock",           limit: 4
    t.integer  "AlertPercentMin",     limit: 4,                            default: 0
    t.integer  "AlertPercentMax",     limit: 4,                            default: 0
    t.integer  "PreSaleQuantity",     limit: 4,                            default: 0,  null: false
    t.string   "SupplierID",          limit: 36
    t.integer  "Type",                limit: 4
    t.integer  "ActivityNum",         limit: 4,                            default: 0
    t.integer  "AddActivityNum",      limit: 4
    t.integer  "SubActivityNum",      limit: 4
  end

  add_index "depotproductstocks", ["DepotID"], name: "IX_DepotID", using: :btree
  add_index "depotproductstocks", ["ProductID"], name: "IX_ProductID", using: :btree

  create_table "depotproductstocksbaks", primary_key: "ID", force: :cascade do |t|
    t.string   "DepotID",     limit: 36,  default: "", null: false
    t.string   "ProductID",   limit: 36,  default: "", null: false
    t.string   "ProductCode", limit: 255
    t.integer  "Stock",       limit: 4,                null: false
    t.datetime "CreateTime"
    t.string   "CreateBy",    limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",    limit: 100
    t.integer  "DamageStock", limit: 4
    t.string   "DutyPerson",  limit: 255
    t.date     "BAKDATE"
  end

  create_table "depots", primary_key: "ID", force: :cascade do |t|
    t.string   "Code",           limit: 255
    t.string   "Name",           limit: 255
    t.string   "Province",       limit: 255
    t.string   "City",           limit: 255
    t.string   "Area",           limit: 255
    t.string   "Address",        limit: 255
    t.integer  "State",          limit: 4
    t.string   "EmployeeName",   limit: 255
    t.string   "Mobile",         limit: 255
    t.integer  "DepotType",      limit: 4
    t.datetime "CreateTime"
    t.string   "CreateBy",       limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",       limit: 100
    t.string   "RelevanceID",    limit: 36
    t.integer  "NumberNehicles", limit: 4,   default: 0
    t.string   "CompanyID",      limit: 36
    t.integer  "WarehouseType",  limit: 4
  end

  add_index "depots", ["CompanyID"], name: "IDX_COMPANYID", using: :btree
  add_index "depots", ["ID"], name: "index_ID", using: :btree

  create_table "depotsendcounties", primary_key: "ID", force: :cascade do |t|
    t.string   "DepotID",    limit: 36,  default: "", null: false
    t.string   "CountyID",   limit: 36,  default: "", null: false
    t.datetime "CreateTime"
    t.string   "CreateBy",   limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",   limit: 100
  end

  create_table "depotshelves", primary_key: "ID", force: :cascade do |t|
    t.string   "DepotID",    limit: 36,  default: "", null: false
    t.string   "Code",       limit: 255
    t.string   "Name",       limit: 255
    t.string   "Remark",     limit: 255
    t.datetime "CreateTime"
    t.string   "CreateBy",   limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",   limit: 100
    t.string   "BarCode",    limit: 255
    t.integer  "Type",       limit: 4
  end

  add_index "depotshelves", ["DepotID"], name: "IX_DepotID", using: :btree

  create_table "depotshiftdetails", primary_key: "ID", force: :cascade do |t|
    t.string   "DepotShiftID",     limit: 36
    t.string   "ProductID",        limit: 36
    t.string   "ProductName",      limit: 255
    t.string   "ProductCode",      limit: 255
    t.integer  "ProductNumber",    limit: 4
    t.integer  "ReceivedNumber",   limit: 4
    t.datetime "CreateTime"
    t.string   "CreateBy",         limit: 255
    t.datetime "UpdateTime"
    t.string   "UpdateBy",         limit: 255
    t.string   "Unit",             limit: 255
    t.string   "Specification",    limit: 255
    t.integer  "DepotStock",       limit: 4
    t.string   "DepotStockName",   limit: 255
    t.integer  "SendNumber",       limit: 4
    t.string   "DepotShelfID",     limit: 36
    t.string   "DepotTrayID",      limit: 36
    t.datetime "ExpirationDate"
    t.decimal  "AvgPurchasePrice",             precision: 18, scale: 4, default: 0.0
    t.string   "InProductID",      limit: 36
    t.integer  "Type",             limit: 4
    t.string   "SupplierID",       limit: 36
  end

  add_index "depotshiftdetails", ["DepotShiftID"], name: "FK_DepotShiftDetails_DepotShifts_DepotShiftID", using: :btree

  create_table "depotshifts", primary_key: "ID", force: :cascade do |t|
    t.string   "ShiftCode",            limit: 255
    t.string   "CompanyOut",           limit: 36
    t.string   "DepotOut",             limit: 36
    t.string   "CompanyIN",            limit: 36
    t.string   "DepotIn",              limit: 36
    t.datetime "EstimateDepotInDate"
    t.string   "ShiftCause",           limit: 255
    t.string   "ShiftName",            limit: 255
    t.integer  "Status",               limit: 4
    t.string   "DriverName",           limit: 255
    t.string   "DriverTel",            limit: 255
    t.datetime "CreateTime"
    t.string   "CreateBy",             limit: 255
    t.datetime "UpdateTime"
    t.string   "UpdateBy",             limit: 255
    t.string   "PurchasingContact",    limit: 255
    t.float    "Freight",              limit: 24
    t.string   "PurchasingContactTel", limit: 255
    t.string   "DepotInName",          limit: 255
    t.string   "DepotOutname",         limit: 255
    t.string   "DepotInAddress",       limit: 255
    t.string   "DepotInLinkman",       limit: 255
    t.string   "DepotInLinkmanTel",    limit: 255
    t.integer  "DistributionState",    limit: 4
  end

  create_table "depotshiftslogs", primary_key: "ID", force: :cascade do |t|
    t.string   "ShiftCode",            limit: 255
    t.string   "DepotOut",             limit: 36
    t.string   "DepotIn",              limit: 36
    t.datetime "EstimateDepotInDate"
    t.string   "ShiftCause",           limit: 255
    t.string   "ShiftName",            limit: 255
    t.integer  "Status",               limit: 4
    t.string   "DriverName",           limit: 255
    t.string   "DriverTel",            limit: 255
    t.datetime "CreateTime"
    t.string   "CreateBy",             limit: 255
    t.datetime "UpdateTime"
    t.string   "UpdateBy",             limit: 255
    t.string   "IP",                   limit: 255
    t.string   "Agent",                limit: 255
    t.string   "DepotShiftsID",        limit: 36
    t.string   "PurchasingContact",    limit: 255
    t.float    "Freight",              limit: 24
    t.string   "PurchasingContactTel", limit: 255
    t.string   "DepotInName",          limit: 255
    t.string   "DepotOutname",         limit: 255
    t.string   "DepotInAddress",       limit: 255
    t.string   "DepotInLinkman",       limit: 255
    t.string   "DepotInLinkmanTel",    limit: 255
  end

  create_table "depottrayproductlogs", primary_key: "ID", force: :cascade do |t|
    t.string   "CompanyID",                 limit: 36
    t.string   "DepotID",                   limit: 36
    t.string   "DepotShelfID",              limit: 36
    t.string   "DepotTrayID",               limit: 36
    t.string   "ProductID",                 limit: 36
    t.string   "PurchaseID",                limit: 36
    t.string   "ReturnPurchaseID",          limit: 36
    t.string   "OrderID",                   limit: 36
    t.string   "DepotProductDamageStockID", limit: 36
    t.integer  "Number",                    limit: 4
    t.date     "ExpirationDate"
    t.integer  "Type",                      limit: 4
    t.datetime "CreateTime"
    t.string   "CreateBy",                  limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",                  limit: 100
    t.string   "DepotShiftID",              limit: 36
    t.string   "Cause",                     limit: 255
    t.string   "OrderProductID",            limit: 36
  end

  create_table "depottrayproductstock_adjustment", primary_key: "ID", force: :cascade do |t|
    t.text     "AdjustmentCode", limit: 4294967295
    t.text     "Reason",         limit: 4294967295
    t.string   "CompanyID",      limit: 36
    t.string   "DepotID",        limit: 36
    t.text     "SinglePlayer",   limit: 4294967295
    t.text     "AuditPerson",    limit: 4294967295
    t.datetime "AuditTime"
    t.integer  "Status",         limit: 4
    t.datetime "CreateTime"
    t.string   "CreateBy",       limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",       limit: 100
    t.integer  "AdjustType",     limit: 4
    t.string   "TypeCode",       limit: 255
  end

  create_table "depottrayproductstock_adjustment_details", primary_key: "ID", force: :cascade do |t|
    t.string   "ProductName",                         limit: 255
    t.string   "ProductCode",                         limit: 255
    t.integer  "AdjustmentNumber",                    limit: 4,          null: false
    t.string   "DepotShelfID",                        limit: 36
    t.string   "DepotTrayID",                         limit: 36
    t.text     "DepotTrayName",                       limit: 4294967295
    t.string   "ProductID",                           limit: 36
    t.text     "ExpirationDate",                      limit: 4294967295
    t.text     "ShelfName",                           limit: 4294967295
    t.integer  "Stock",                               limit: 4
    t.string   "AdjustmentID",                        limit: 36
    t.datetime "CreateTime"
    t.string   "CreateBy",                            limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",                            limit: 100
    t.string   "DepotTrayProductStock_Adjustment_ID", limit: 36
    t.string   "PurchaseDetailID",                    limit: 36
    t.boolean  "IsGift",                              limit: 1
  end

  create_table "depottrayproductstock_adjustmentlogs", primary_key: "ID", force: :cascade do |t|
    t.text     "AdjustmentCode", limit: 4294967295
    t.string   "AdjustmentID",   limit: 36
    t.text     "operationType",  limit: 4294967295
    t.integer  "AdjustType",     limit: 4
    t.datetime "CreateTime"
    t.string   "CreateBy",       limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",       limit: 100
  end

  create_table "depottrayproductstocks", primary_key: "ID", force: :cascade do |t|
    t.string   "CompanyID",            limit: 36
    t.string   "DepotID",              limit: 36
    t.string   "DepotTrayID",          limit: 36
    t.string   "ProductID",            limit: 36
    t.date     "ExpirationDate"
    t.integer  "Stock",                limit: 4
    t.binary   "IsDeleted",            limit: 1
    t.datetime "CreateTime"
    t.string   "CreateBy",             limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",             limit: 100
    t.string   "DepotShiftDetails_ID", limit: 36
  end

  create_table "depottrays", primary_key: "ID", force: :cascade do |t|
    t.string   "DepotID",      limit: 36
    t.string   "DepotShelfID", limit: 36
    t.integer  "Code",         limit: 4
    t.string   "BarCode",      limit: 255
    t.string   "Remark",       limit: 255
    t.datetime "CreateTime"
    t.string   "CreateBy",     limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",     limit: 100
  end

  add_index "depottrays", ["BarCode"], name: "unique_tray_barcode", unique: true, using: :btree

  create_table "driverinfoes", primary_key: "ID", force: :cascade do |t|
    t.string   "DriverCode",   limit: 255
    t.string   "DriverName",   limit: 255
    t.string   "DriverMoible", limit: 255
    t.string   "LicensePlate", limit: 255
    t.datetime "CreateTime"
    t.string   "CreateBy",     limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",     limit: 100
    t.string   "CarTypeID",    limit: 36
  end

  create_table "ebmorderproducts", primary_key: "ID", force: :cascade do |t|
    t.string   "EbmOrderID",        limit: 36
    t.string   "EbmProductCode",    limit: 255
    t.string   "EbmProductCodeOld", limit: 255
    t.string   "ProductID",         limit: 36
    t.string   "ProductName",       limit: 255
    t.decimal  "Price",                         precision: 18, scale: 2
    t.integer  "Quantity",          limit: 4
    t.datetime "CreateTime"
    t.string   "CreateBy",          limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",          limit: 100
  end

  create_table "ebmorders", primary_key: "ID", force: :cascade do |t|
    t.string   "EbmOrderCode", limit: 255
    t.string   "OrderID",      limit: 36
    t.string   "Name",         limit: 255
    t.string   "Tel",          limit: 255
    t.string   "Province",     limit: 255
    t.string   "City",         limit: 255
    t.string   "County",       limit: 255
    t.string   "Address",      limit: 255
    t.string   "Message",      limit: 255
    t.string   "Money",        limit: 255
    t.boolean  "Status",       limit: 1
    t.datetime "CreateTime"
    t.string   "CreateBy",     limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",     limit: 100
  end

  create_table "emaillogfileattachments", id: false, force: :cascade do |t|
    t.string "EmailLog_ID",       limit: 36, default: "", null: false
    t.string "FileAttachment_ID", limit: 36, default: "", null: false
  end

  add_index "emaillogfileattachments", ["EmailLog_ID"], name: "IX_EmailLog_ID", using: :btree
  add_index "emaillogfileattachments", ["FileAttachment_ID"], name: "IX_FileAttachment_ID", using: :btree

  create_table "emaillogs", primary_key: "ID", force: :cascade do |t|
    t.string   "FrameModuleID",   limit: 36
    t.text     "ReceiverAddress", limit: 4294967295, null: false
    t.text     "EmailTitle",      limit: 4294967295, null: false
    t.text     "EmailContent",    limit: 4294967295
    t.text     "CCAddress",       limit: 4294967295
    t.integer  "EmailType",       limit: 4,          null: false
    t.integer  "SendStatus",      limit: 4,          null: false
    t.datetime "SendTime"
    t.datetime "CreateTime"
    t.string   "CreateBy",        limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",        limit: 100
  end

  add_index "emaillogs", ["FrameModuleID"], name: "IX_FrameModuleID", using: :btree

  create_table "emailtemplates", primary_key: "ID", force: :cascade do |t|
    t.string   "Code",         limit: 50,         null: false
    t.string   "Title",        limit: 500,        null: false
    t.text     "Content",      limit: 4294967295
    t.text     "Remark",       limit: 4294967295
    t.text     "ContorlName",  limit: 4294967295
    t.integer  "EmailType",    limit: 4
    t.text     "TemplateType", limit: 4294967295
    t.datetime "CreateTime"
    t.string   "CreateBy",     limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",     limit: 100
  end

  create_table "enchashes", primary_key: "ID", force: :cascade do |t|
    t.string   "Key",        limit: 36,  default: "", null: false
    t.integer  "Hash",       limit: 4,                null: false
    t.datetime "CreateTime"
    t.string   "CreateBy",   limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",   limit: 100
  end

  create_table "enshrines", primary_key: "ID", force: :cascade do |t|
    t.datetime "CreateTime"
    t.string   "CreateBy",   limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",   limit: 100
    t.string   "ProductID",  limit: 36
    t.string   "UserID",     limit: 36
  end

  add_index "enshrines", ["ProductID"], name: "IX_ProductID", using: :btree
  add_index "enshrines", ["UserID"], name: "IX_UserID", using: :btree

  create_table "fileattachments", primary_key: "ID", force: :cascade do |t|
    t.string   "FileName",     limit: 255,        null: false
    t.string   "FileExt",      limit: 10,         null: false
    t.string   "Path",         limit: 255
    t.integer  "Length",       limit: 8,          null: false
    t.datetime "UploadTime",                      null: false
    t.boolean  "IsTemprory",   limit: 1,          null: false
    t.integer  "SaveFileMode", limit: 4
    t.string   "GroupName",    limit: 100
    t.datetime "CreateTime"
    t.string   "CreateBy",     limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",     limit: 100
    t.binary   "FileData",     limit: 4294967295
  end

  create_table "financemonthlysettlements", primary_key: "ID", force: :cascade do |t|
    t.integer  "Year",                              limit: 2
    t.integer  "Month",                             limit: 2
    t.datetime "BeginTime"
    t.datetime "EndTime"
    t.string   "CompanyID",                         limit: 36
    t.string   "DepotID",                           limit: 36
    t.string   "ProductID",                         limit: 36
    t.decimal  "PurchasePrice",                                 precision: 18, scale: 4, default: 0.0
    t.decimal  "PurchasePriceBySalesyProxies",                  precision: 18, scale: 4, default: 0.0
    t.integer  "RealStock",                         limit: 4,                            default: 0
    t.integer  "RealStockBySalesyProxies",          limit: 4,                            default: 0
    t.integer  "OutNumber",                         limit: 4,                            default: 0
    t.integer  "OutNumberBySalesyProxies",          limit: 4,                            default: 0
    t.integer  "InNumber",                          limit: 4,                            default: 0
    t.integer  "InNumberBySalesyProxies",           limit: 4,                            default: 0
    t.decimal  "DiscountTotalPrice",                            precision: 18, scale: 4, default: 0.0
    t.decimal  "DiscountTotalPriceBySalesyProxies",             precision: 18, scale: 4, default: 0.0
    t.decimal  "MarketingTotalPrice",                           precision: 18, scale: 4, default: 0.0
    t.decimal  "ReceviedTotalPrice",                            precision: 18, scale: 4, default: 0.0
    t.datetime "CreateTime"
    t.string   "CreateBy",                          limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",                          limit: 100
  end

  create_table "financial_depot_product_stock", id: false, force: :cascade do |t|
    t.integer  "Year",       limit: 4,               null: false
    t.integer  "Month",      limit: 4,               null: false
    t.string   "DepotID",    limit: 36, default: "", null: false
    t.string   "ProductID",  limit: 36, default: "", null: false
    t.integer  "RealStock",  limit: 8,  default: 0,  null: false
    t.datetime "CreateTime",                         null: false
  end

  add_index "financial_depot_product_stock", ["DepotID"], name: "Index_DepotID", using: :btree
  add_index "financial_depot_product_stock", ["ProductID"], name: "Index_ProductID", using: :btree

  create_table "financial_month", id: false, force: :cascade do |t|
    t.integer  "Year",      limit: 4, default: 0, null: false
    t.integer  "Month",     limit: 4, default: 0, null: false
    t.datetime "BeginTime",                       null: false
    t.datetime "EndTime",                         null: false
  end

  create_table "financial_purchase_price", id: false, force: :cascade do |t|
    t.integer  "Year",             limit: 4,                                         null: false
    t.integer  "Month",            limit: 4,                                         null: false
    t.string   "CompanyID",        limit: 36,                                        null: false
    t.string   "DepotID",          limit: 36,                                        null: false
    t.string   "ProductID",        limit: 36,                                        null: false
    t.decimal  "AvgPurchasePrice",            precision: 18, scale: 4, default: 0.0, null: false
    t.datetime "CreateTime"
  end

  add_index "financial_purchase_price", ["CompanyID"], name: "Index_CompanyID", using: :btree
  add_index "financial_purchase_price", ["DepotID"], name: "Index_DepotID", using: :btree
  add_index "financial_purchase_price", ["Month"], name: "Index_Month", using: :btree
  add_index "financial_purchase_price", ["ProductID"], name: "Index_ProductID", using: :btree

  create_table "financialfirstlevels", primary_key: "ID", force: :cascade do |t|
    t.text     "Code",       limit: 4294967295
    t.text     "Name",       limit: 4294967295
    t.integer  "IsEnable",   limit: 4
    t.datetime "CreateTime"
    t.string   "CreateBy",   limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",   limit: 100
  end

  create_table "financialsecondlevels", primary_key: "ID", force: :cascade do |t|
    t.text     "Code",                  limit: 4294967295
    t.text     "Name",                  limit: 4294967295
    t.integer  "IsEnable",              limit: 4
    t.string   "FinancialFirstLevelID", limit: 36,         default: "", null: false
    t.datetime "CreateTime"
    t.string   "CreateBy",              limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",              limit: 100
  end

  add_index "financialsecondlevels", ["FinancialFirstLevelID"], name: "IX_FinancialFirstLevelID", using: :btree

  create_table "focus_order_pick_details_models", primary_key: "ID", force: :cascade do |t|
    t.string   "CompanyID",             limit: 36
    t.string   "DepotID",               limit: 36
    t.string   "DepotShelfID",          limit: 36
    t.string   "DepotTrayID",           limit: 36
    t.string   "ProductID",             limit: 36
    t.string   "OrderID",               limit: 36
    t.integer  "Number",                limit: 4
    t.date     "ExpirationDate"
    t.integer  "Type",                  limit: 4
    t.datetime "CreateTime"
    t.string   "CreateBy",              limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",              limit: 100
    t.string   "DepotShiftID",          limit: 36
    t.string   "Cause",                 limit: 255
    t.string   "OrderProductID",        limit: 36
    t.string   "FocusOrderPickModelID", limit: 36
  end

  create_table "focus_order_pick_models", primary_key: "ID", force: :cascade do |t|
    t.string   "FocusOrderCode", limit: 255
    t.string   "BatchID",        limit: 36
    t.integer  "status",         limit: 4
    t.datetime "CreateTime"
    t.string   "CreateBy",       limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",       limit: 100
    t.string   "OrderID",        limit: 36
  end

  create_table "frameworkactionmlcontents", primary_key: "ID", force: :cascade do |t|
    t.string "ActionName",   limit: 50
    t.text   "LanguageCode", limit: 4294967295
    t.string "MLParentID",   limit: 36,         default: "", null: false
  end

  add_index "frameworkactionmlcontents", ["MLParentID"], name: "IX_MLParentID", using: :btree

  create_table "frameworkactions", primary_key: "ID", force: :cascade do |t|
    t.string   "MethodName", limit: 50,  null: false
    t.string   "ModuleID",   limit: 36
    t.string   "Parameter",  limit: 255
    t.datetime "CreateTime"
    t.string   "CreateBy",   limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",   limit: 100
  end

  add_index "frameworkactions", ["ModuleID"], name: "IX_ModuleID", using: :btree

  create_table "frameworkareamlcontents", primary_key: "ID", force: :cascade do |t|
    t.string "AreaName",     limit: 50
    t.text   "LanguageCode", limit: 4294967295
    t.string "MLParentID",   limit: 36,         default: "", null: false
  end

  add_index "frameworkareamlcontents", ["MLParentID"], name: "IX_MLParentID", using: :btree

  create_table "frameworkareas", primary_key: "ID", force: :cascade do |t|
    t.string   "Prefix",     limit: 50,  null: false
    t.datetime "CreateTime"
    t.string   "CreateBy",   limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",   limit: 100
  end

  create_table "frameworkcompanies", primary_key: "ID", force: :cascade do |t|
    t.string   "CompanyCode",   limit: 6,   null: false
    t.datetime "CreateTime"
    t.string   "CreateBy",      limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",      limit: 100
    t.string   "CompanyNameCN", limit: 100
    t.integer  "ThirdType",     limit: 4
  end

  create_table "frameworkcompanymlcontents", primary_key: "ID", force: :cascade do |t|
    t.string "CompanyName",   limit: 100
    t.text   "CompanyRemark", limit: 4294967295
    t.text   "LanguageCode",  limit: 4294967295
    t.string "MLParentID",    limit: 36,         default: "", null: false
  end

  add_index "frameworkcompanymlcontents", ["MLParentID"], name: "IX_MLParentID", using: :btree

  create_table "frameworkdepartmentmlcontents", primary_key: "ID", force: :cascade do |t|
    t.string "DepartmentName", limit: 50
    t.text   "LanguageCode",   limit: 4294967295
    t.string "MLParentID",     limit: 36,         default: "", null: false
  end

  add_index "frameworkdepartmentmlcontents", ["MLParentID"], name: "IX_MLParentID", using: :btree

  create_table "frameworkdepartments", primary_key: "ID", force: :cascade do |t|
    t.string   "DepartmentCode",   limit: 6,                null: false
    t.integer  "UserType",         limit: 4,                null: false
    t.string   "CompanyID",        limit: 36,  default: "", null: false
    t.string   "ParentID",         limit: 36
    t.datetime "CreateTime"
    t.string   "CreateBy",         limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",         limit: 100
    t.string   "DepartmentNameCN", limit: 100
  end

  add_index "frameworkdepartments", ["CompanyID"], name: "IX_CompanyID", using: :btree
  add_index "frameworkdepartments", ["ParentID"], name: "IX_ParentID", using: :btree

  create_table "frameworkdomainmlcontents", primary_key: "ID", force: :cascade do |t|
    t.string "DomainName",   limit: 50
    t.text   "LanguageCode", limit: 4294967295
    t.string "MLParentID",   limit: 36,         default: "", null: false
  end

  add_index "frameworkdomainmlcontents", ["MLParentID"], name: "IX_MLParentID", using: :btree

  create_table "frameworkdomains", primary_key: "ID", force: :cascade do |t|
    t.string   "DomainAddress", limit: 50,         null: false
    t.integer  "DomainPort",    limit: 4
    t.text     "EntryUrl",      limit: 4294967295
    t.datetime "CreateTime"
    t.string   "CreateBy",      limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",      limit: 100
  end

  create_table "frameworkfactories", primary_key: "ID", force: :cascade do |t|
    t.text     "FactoryName", limit: 4294967295
    t.datetime "CreateTime"
    t.string   "CreateBy",    limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",    limit: 100
  end

  create_table "frameworkmenumlcontents", primary_key: "ID", force: :cascade do |t|
    t.string "PageName",     limit: 50
    t.text   "ActionName",   limit: 4294967295
    t.text   "ModuleName",   limit: 4294967295
    t.text   "LanguageCode", limit: 4294967295
    t.string "MLParentID",   limit: 36,         default: "", null: false
  end

  add_index "frameworkmenumlcontents", ["MLParentID"], name: "IX_MLParentID", using: :btree

  create_table "frameworkmenus", primary_key: "ID", force: :cascade do |t|
    t.boolean  "FolderOnly",   limit: 1,          null: false
    t.boolean  "IsInherit",    limit: 1,          null: false
    t.string   "ActionID",     limit: 36
    t.string   "ModuleID",     limit: 36
    t.string   "DomainID",     limit: 36
    t.boolean  "ShowOnMenu",   limit: 1,          null: false
    t.boolean  "IsPublic",     limit: 1,          null: false
    t.integer  "DisplayOrder", limit: 4,          null: false
    t.boolean  "IsInside",     limit: 1,          null: false
    t.text     "Url",          limit: 4294967295
    t.string   "IconID",       limit: 36
    t.string   "ParentID",     limit: 36
    t.datetime "CreateTime"
    t.string   "CreateBy",     limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",     limit: 100
  end

  add_index "frameworkmenus", ["DomainID"], name: "IX_DomainID", using: :btree
  add_index "frameworkmenus", ["IconID"], name: "IX_IconID", using: :btree
  add_index "frameworkmenus", ["ParentID"], name: "IX_ParentID", using: :btree

  create_table "frameworkmessages", primary_key: "ID", force: :cascade do |t|
    t.integer  "MessageType", limit: 4,          null: false
    t.text     "Content",     limit: 4294967295, null: false
    t.string   "Receiver",    limit: 100,        null: false
    t.boolean  "IsRead",      limit: 1,          null: false
    t.datetime "CreateTime"
    t.string   "CreateBy",    limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",    limit: 100
  end

  create_table "frameworkmodulemlcontents", primary_key: "ID", force: :cascade do |t|
    t.string "ModuleName",   limit: 50
    t.text   "LanguageCode", limit: 4294967295
    t.string "MLParentID",   limit: 36,         default: "", null: false
  end

  add_index "frameworkmodulemlcontents", ["MLParentID"], name: "IX_MLParentID", using: :btree

  create_table "frameworkmodules", primary_key: "ID", force: :cascade do |t|
    t.string   "ClassName",  limit: 50,         null: false
    t.string   "AreaID",     limit: 36
    t.text     "NameSpace",  limit: 4294967295
    t.datetime "CreateTime"
    t.string   "CreateBy",   limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",   limit: 100
  end

  add_index "frameworkmodules", ["AreaID"], name: "IX_AreaID", using: :btree

  create_table "frameworknotices", primary_key: "ID", force: :cascade do |t|
    t.text     "Content",    limit: 4294967295, null: false
    t.text     "RoleIDs",    limit: 4294967295
    t.datetime "BeginTime",                     null: false
    t.datetime "EndTime",                       null: false
    t.datetime "CreateTime"
    t.string   "CreateBy",   limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",   limit: 100
  end

  create_table "frameworkonlines", primary_key: "ID", force: :cascade do |t|
    t.text     "ITCode",    limit: 4294967295
    t.boolean  "IsOnLine",  limit: 1,          null: false
    t.datetime "LastLogin",                    null: false
    t.datetime "LastCheck",                    null: false
  end

  create_table "frameworkrolemlcontents", primary_key: "ID", force: :cascade do |t|
    t.string "RoleName",     limit: 50
    t.text   "RoleRemark",   limit: 4294967295
    t.text   "LanguageCode", limit: 4294967295
    t.string "MLParentID",   limit: 36,         default: "", null: false
  end

  add_index "frameworkrolemlcontents", ["MLParentID"], name: "IX_MLParentID", using: :btree

  create_table "frameworkroles", primary_key: "ID", force: :cascade do |t|
    t.string   "RoleCode",     limit: 6,   null: false
    t.datetime "CreateTime"
    t.string   "CreateBy",     limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",     limit: 100
    t.string   "WFDefNode_ID", limit: 36
  end

  add_index "frameworkroles", ["WFDefNode_ID"], name: "IX_WFDefNode_ID", using: :btree

  create_table "frameworkuser", primary_key: "ID", force: :cascade do |t|
    t.string   "ITCode",         limit: 100, null: false
    t.string   "Email",          limit: 100
    t.string   "Name",           limit: 50,  null: false
    t.datetime "CreateTime"
    t.string   "CreateBy",       limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",       limit: 100
    t.string   "Password",       limit: 32
    t.string   "WorkPhone",      limit: 30
    t.string   "CellPhone",      limit: 30
    t.string   "HomePhone",      limit: 30
    t.string   "Fax",            limit: 30
    t.string   "Address",        limit: 200
    t.string   "ZipCode",        limit: 6
    t.datetime "StartWorkDate"
    t.boolean  "IsValid",        limit: 1
    t.string   "PhotoID",        limit: 36
    t.string   "DepartmentID",   limit: 36
    t.integer  "UserType",       limit: 4
    t.string   "WFDefNode_ID",   limit: 36
    t.string   "UserCode",       limit: 50
    t.string   "CompanyID",      limit: 36
    t.string   "DingTalkUserID", limit: 36
    t.string   "RememberToken",  limit: 255
  end

  add_index "frameworkuser", ["DepartmentID"], name: "IX_DepartmentID", using: :btree
  add_index "frameworkuser", ["PhotoID"], name: "IX_PhotoID", using: :btree
  add_index "frameworkuser", ["WFDefNode_ID"], name: "IX_WFDefNode_ID", using: :btree

  create_table "frameworkuserrole", id: false, force: :cascade do |t|
    t.string "FrameworkUserBase_ID", limit: 36, default: "", null: false
    t.string "FrameworkRole_ID",     limit: 36, default: "", null: false
  end

  add_index "frameworkuserrole", ["FrameworkRole_ID"], name: "IX_FrameworkRole_ID", using: :btree
  add_index "frameworkuserrole", ["FrameworkUserBase_ID"], name: "IX_FrameworkUserBase_ID", using: :btree

  create_table "fullgiftactivities", primary_key: "ID", force: :cascade do |t|
    t.string   "CompanyID",       limit: 36
    t.string   "OrderID",         limit: 36
    t.string   "Province",        limit: 255
    t.string   "UserID",          limit: 36
    t.string   "Address",         limit: 255
    t.decimal  "ReceivedPrice",               precision: 18, scale: 4
    t.integer  "ShouldCount",     limit: 4
    t.integer  "SendCount",       limit: 4
    t.datetime "CreateTime"
    t.string   "CreateBy",        limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",        limit: 100
    t.integer  "CumulativeCount", limit: 4
    t.decimal  "CumulativePrice",             precision: 18, scale: 4
  end

  add_index "fullgiftactivities", ["UserID"], name: "UserID", unique: true, using: :btree

  create_table "functionprivileges", primary_key: "ID", force: :cascade do |t|
    t.string   "RoleID",     limit: 36
    t.string   "UserID",     limit: 36
    t.string   "MenuItemId", limit: 36,  default: "", null: false
    t.boolean  "Allowed",    limit: 1,                null: false
    t.datetime "CreateTime"
    t.string   "CreateBy",   limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",   limit: 100
  end

  add_index "functionprivileges", ["MenuItemId"], name: "IX_MenuItemId", using: :btree

  create_table "generatecodes", primary_key: "ID", force: :cascade do |t|
    t.string   "CodeType",   limit: 255
    t.integer  "Number",     limit: 4,   null: false
    t.datetime "CreateTime"
    t.string   "CreateBy",   limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",   limit: 100
  end

  create_table "gift_bag_coupons", primary_key: "ID", force: :cascade do |t|
    t.string   "GiftBagID",     limit: 36
    t.string   "CouponID",      limit: 36
    t.string   "Title",         limit: 255
    t.string   "SubTitle",      limit: 255
    t.datetime "CreateTime"
    t.string   "CreateBy",      limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",      limit: 100
    t.decimal  "CouponPrice",               precision: 8, scale: 2
    t.integer  "ActivityPrice", limit: 4
    t.integer  "CouponDays",    limit: 4
    t.string   "CouponType",    limit: 50
    t.decimal  "MaxPrice",                  precision: 8, scale: 2
  end

  create_table "gift_bag_logs", primary_key: "ID", force: :cascade do |t|
    t.string   "GiftBagID",  limit: 36
    t.string   "Remark",     limit: 255
    t.integer  "Status",     limit: 4
    t.string   "IP",         limit: 255
    t.string   "Agent",      limit: 255
    t.datetime "CreateTime"
    t.string   "CreateBy",   limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",   limit: 100
  end

  create_table "gift_bags", primary_key: "ID", force: :cascade do |t|
    t.string   "CompanyID",  limit: 36
    t.string   "Name",       limit: 255
    t.decimal  "Money",                  precision: 8, scale: 2
    t.integer  "State",      limit: 1
    t.integer  "Status",     limit: 4
    t.integer  "Type",       limit: 4
    t.datetime "CreateTime"
    t.string   "CreateBy",   limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",   limit: 100
  end

  create_table "goldusercoupons", primary_key: "ID", force: :cascade do |t|
    t.string   "UserID",          limit: 36,  null: false
    t.string   "UserCouponID",    limit: 36,  null: false
    t.string   "StatisticsMonth", limit: 255, null: false
    t.datetime "CreateTime"
    t.string   "CreateBy",        limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",        limit: 100
  end

  create_table "groupproducts", primary_key: "ID", force: :cascade do |t|
    t.string   "ProductID",       limit: 36
    t.string   "SubProductID",    limit: 36
    t.string   "SubProductCode",  limit: 255
    t.string   "SubProductName",  limit: 255
    t.integer  "Number",          limit: 4
    t.decimal  "Price",                       precision: 18, scale: 2
    t.datetime "CreateTime"
    t.string   "CreateBy",        limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",        limit: 100
    t.decimal  "SubProductPrice",             precision: 18, scale: 4, default: 0.0
    t.decimal  "PriceProportion",             precision: 18, scale: 2, default: 0.0
    t.decimal  "DiscountRate",                precision: 18, scale: 2
  end

  add_index "groupproducts", ["ProductID", "SubProductID"], name: "IDX_PRODUCTID_SUBPRODUCTID", using: :btree

  create_table "hflooritembrands", primary_key: "ID", force: :cascade do |t|
    t.string   "HFloorItemID",   limit: 36
    t.string   "ProductBrandID", limit: 36
    t.integer  "BrandCode",      limit: 4
    t.text     "BrandName",      limit: 4294967295
    t.datetime "CreateTime"
    t.string   "CreateBy",       limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",       limit: 100
    t.integer  "Sort",           limit: 4
  end

  create_table "hflooritemgroups", primary_key: "ID", force: :cascade do |t|
    t.string   "HFloorItemID",   limit: 36
    t.string   "ProductGroupID", limit: 36
    t.datetime "CreateTime"
    t.string   "CreateBy",       limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",       limit: 100
    t.string   "GroupName",      limit: 100
    t.integer  "Sort",           limit: 4
  end

  create_table "hflooritemproducts", primary_key: "ID", force: :cascade do |t|
    t.string   "HFloorItemID",  limit: 36
    t.string   "ProductID",     limit: 36
    t.string   "ProductName",   limit: 255
    t.string   "ProductCode",   limit: 255
    t.text     "Specification", limit: 4294967295
    t.string   "unit",          limit: 255
    t.decimal  "ProductPrice",                     precision: 18, scale: 4
    t.datetime "CreateTime"
    t.string   "CreateBy",      limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",      limit: 100
    t.integer  "Sort",          limit: 4
  end

  add_index "hflooritemproducts", ["HFloorItemID"], name: "IX_HFloorItemID", using: :btree

  create_table "hflooritems", primary_key: "ID", force: :cascade do |t|
    t.string   "Title",                  limit: 255
    t.string   "SubTitle",               limit: 255
    t.string   "Picture",                limit: 36
    t.string   "LinkUrl",                limit: 255
    t.string   "ThemeColor",             limit: 255
    t.string   "HFloorID",               limit: 36
    t.datetime "CreateTime"
    t.string   "CreateBy",               limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",               limit: 100
    t.string   "ProductRecommendInfoID", limit: 36
    t.string   "PictureQiNiu",           limit: 36
    t.integer  "Sort",                   limit: 4
    t.boolean  "IsSeckill",              limit: 1
    t.integer  "Squareworkshop",         limit: 4
    t.boolean  "IsEnabled",              limit: 1
  end

  create_table "hfloors", primary_key: "ID", force: :cascade do |t|
    t.string   "FloorName",      limit: 255
    t.string   "ShowName",       limit: 255
    t.integer  "Sort",           limit: 4
    t.boolean  "NeedNav",        limit: 1
    t.string   "NavIcon",        limit: 36
    t.integer  "TerminalType",   limit: 4
    t.string   "NavIconQiNiu",   limit: 36
    t.integer  "LayoutType",     limit: 4
    t.string   "HPageConfigID",  limit: 36
    t.datetime "CreateTime"
    t.string   "CreateBy",       limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",       limit: 100
    t.string   "CompanyID",      limit: 36
    t.boolean  "IsShowName",     limit: 1
    t.boolean  "IsEnabled",      limit: 1
    t.integer  "Squareworkshop", limit: 4
  end

  create_table "hpageconfigs", primary_key: "ID", force: :cascade do |t|
    t.string   "Title",        limit: 255
    t.integer  "IsEnabled",    limit: 1
    t.datetime "EnableTime"
    t.integer  "TerminalType", limit: 4
    t.string   "Remark",       limit: 255
    t.string   "CompanyID",    limit: 36
    t.datetime "CreateTime"
    t.string   "CreateBy",     limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",     limit: 100
  end

  create_table "idgenerate", primary_key: "Id", force: :cascade do |t|
    t.string  "IdName",  limit: 64, null: false
    t.integer "IdLen",   limit: 4,  null: false
    t.integer "NextNum", limit: 4,  null: false
    t.integer "Step",    limit: 4,  null: false
  end

  create_table "invitations", id: false, force: :cascade do |t|
    t.string   "ID",          limit: 36,                  null: false
    t.string   "UserID",      limit: 36
    t.string   "Phone",       limit: 255
    t.datetime "CreateTime"
    t.datetime "UpdateTime"
    t.float    "CouponPrice", limit: 24
    t.float    "UseMoney",    limit: 24,  default: 500.0
    t.integer  "TypeID",      limit: 4
    t.string   "Remark",      limit: 255
  end

  add_index "invitations", ["Phone"], name: "index_Invitation_on_Phone", using: :btree
  add_index "invitations", ["UserID"], name: "index_Invitations_on_UserID", using: :btree

  create_table "jhbmailinfoes", primary_key: "ID", force: :cascade do |t|
    t.text     "MailAddress",  limit: 65535
    t.string   "MailTitle",    limit: 200
    t.string   "MailTypeID",   limit: 36
    t.datetime "MailSendTime"
    t.boolean  "IsEnabled",    limit: 1
    t.string   "CompanyID",    limit: 36
    t.datetime "CreateTime"
    t.string   "CreateBy",     limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",     limit: 100
    t.string   "DepotID",      limit: 36
  end

  add_index "jhbmailinfoes", ["MailTypeID"], name: "IX_MailTypeID", using: :btree

  create_table "jhbmailtypes", primary_key: "ID", force: :cascade do |t|
    t.text     "MailCode",   limit: 4294967295
    t.text     "MailType",   limit: 4294967295
    t.datetime "CreateTime"
    t.string   "CreateBy",   limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",   limit: 100
  end

  create_table "keyword_search_histories", primary_key: "ID", force: :cascade do |t|
    t.string   "UserID",      limit: 36
    t.string   "KeyWordName", limit: 255
    t.datetime "CreateTime"
    t.datetime "UpdateTime"
    t.boolean  "IsDeleted",   limit: 1,   default: false
  end

  add_index "keyword_search_histories", ["UserID"], name: "index_keyword_search_histories_on_UserID", using: :btree

  create_table "keywordmanagements", primary_key: "ID", force: :cascade do |t|
    t.text     "KeyWordCode", limit: 4294967295
    t.text     "KeyWordName", limit: 4294967295
    t.integer  "orderBy",     limit: 4
    t.datetime "CreateTime"
    t.string   "CreateBy",    limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",    limit: 100
    t.string   "CompanyID",   limit: 36
    t.integer  "Type",        limit: 4
  end

  create_table "lfqcontracts", primary_key: "Id", force: :cascade do |t|
    t.string   "OrderCode",     limit: 64,                                       null: false
    t.string   "RandomCode",    limit: 64,                                       null: false
    t.string   "RequestId",     limit: 128,                                      null: false
    t.string   "ContractsCode", limit: 64,                                       null: false
    t.decimal  "Amt",                       precision: 10, scale: 2,             null: false
    t.integer  "Terms",         limit: 1,                                        null: false
    t.datetime "CreateTime",                                                     null: false
    t.integer  "Status",        limit: 1,                            default: 0
  end

  add_index "lfqcontracts", ["RequestId"], name: "idx_LfqContracts_RequestId", using: :btree

  create_table "lossofdocument", primary_key: "ID", force: :cascade do |t|
    t.text     "LossCode",     limit: 4294967295
    t.integer  "LossType",     limit: 4
    t.string   "DepotID",      limit: 36
    t.text     "Remark",       limit: 4294967295
    t.text     "SinglePlayer", limit: 4294967295
    t.text     "AuditPerson",  limit: 4294967295
    t.datetime "AuditTime"
    t.integer  "Status",       limit: 4,          null: false
    t.datetime "CreateTime"
    t.string   "CreateBy",     limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",     limit: 100
  end

  create_table "lossofdocumentdetails", primary_key: "ID", force: :cascade do |t|
    t.string   "ProductName",      limit: 255
    t.string   "ProductCode",      limit: 255
    t.string   "Remark",           limit: 255
    t.integer  "LossNumber",       limit: 4,          null: false
    t.string   "DepotShelfID",     limit: 36
    t.string   "DepotTrayID",      limit: 36
    t.text     "DepotTrayName",    limit: 4294967295
    t.string   "ProductID",        limit: 36
    t.text     "ExpirationDate",   limit: 4294967295
    t.text     "ShelfName",        limit: 4294967295
    t.integer  "Stock",            limit: 4
    t.text     "Specification",    limit: 4294967295
    t.datetime "CreateTime"
    t.string   "CreateBy",         limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",         limit: 100
    t.string   "LossOfDocumentID", limit: 36
    t.integer  "LossStock",        limit: 4,          null: false
  end

  create_table "lotteryhistories", primary_key: "ID", force: :cascade do |t|
    t.string   "UserID",       limit: 36
    t.string   "PrizeName",    limit: 255
    t.datetime "CreateTime"
    t.string   "CreateBy",     limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",     limit: 100
    t.integer  "Type",         limit: 4
    t.string   "ObjectID",     limit: 36
    t.string   "DepotID",      limit: 36
    t.string   "OrderID",      limit: 36
    t.string   "UserCouponID", limit: 36
  end

  create_table "mediareports", primary_key: "ID", force: :cascade do |t|
    t.string   "Title",           limit: 255
    t.text     "Content",         limit: 65535
    t.datetime "CreateTime"
    t.string   "CreateBy",        limit: 255
    t.datetime "UpdateTime"
    t.string   "UpdateBy",        limit: 255
    t.datetime "MediaReportDate"
    t.string   "CoverQiniu",      limit: 255
    t.text     "HtmlShow",        limit: 4294967295
    t.string   "PhotoID",         limit: 36
  end

  create_table "newview", id: false, force: :cascade do |t|
    t.string   "ID",         limit: 36,  default: "", null: false
    t.string   "DepotID",    limit: 36
    t.string   "OrderID",    limit: 36
    t.string   "UserID",     limit: 36
    t.string   "PrizeName",  limit: 255
    t.datetime "CreateTime"
    t.string   "CreateBy",   limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",   limit: 100
    t.integer  "Type",       limit: 4
    t.string   "ObjectID",   limit: 36
    t.string   "Title",      limit: 255
    t.string   "Phone",      limit: 255
  end

  create_table "notices", primary_key: "ID", force: :cascade do |t|
    t.string   "Content",    limit: 255, default: "", null: false
    t.string   "Link",       limit: 255
    t.integer  "Type",       limit: 4,                null: false
    t.datetime "CreateTime"
    t.string   "CreateBy",   limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",   limit: 100
  end

  create_table "notifications", primary_key: "ID", force: :cascade do |t|
    t.string   "UserID",     limit: 36
    t.string   "Content",    limit: 255, default: "",    null: false
    t.integer  "Type",       limit: 4,                   null: false
    t.datetime "CreateTime"
    t.string   "CreateBy",   limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",   limit: 100
    t.string   "Remark",     limit: 255
    t.boolean  "IsRead",     limit: 1,   default: false
  end

  create_table "onlinepaylists", id: false, force: :cascade do |t|
    t.string  "CompanyName", limit: 100
    t.string  "CompanyID",   limit: 36
    t.string  "DepotId",     limit: 36
    t.string  "depotName",   limit: 255
    t.string  "PayDate",     limit: 10
    t.integer "OrderCount",  limit: 8,                            default: 0, null: false
    t.integer "WeChatCount", limit: 8,                            default: 0, null: false
    t.decimal "WeChatTotal",             precision: 40, scale: 2
    t.integer "YeepayCount", limit: 8,                            default: 0, null: false
    t.decimal "YeepayTotal",             precision: 40, scale: 2
    t.integer "TLCount",     limit: 8,                            default: 0, null: false
    t.decimal "TLTotal",                 precision: 40, scale: 2
    t.integer "AliPaycount", limit: 8,                            default: 0, null: false
    t.decimal "alipaytotal",             precision: 40, scale: 2
    t.decimal "XJTotal",                 precision: 40, scale: 2
    t.decimal "Zztotal",                 precision: 40, scale: 2
    t.decimal "Sktotal",                 precision: 40, scale: 2
    t.decimal "Total",                   precision: 46, scale: 2
  end

  create_table "open_screens", primary_key: "ID", force: :cascade do |t|
    t.string   "Title",        limit: 255
    t.string   "Picture",      limit: 36
    t.string   "pictureQiNiu", limit: 36
    t.integer  "IsEnabled",    limit: 1
    t.datetime "CreateTime"
    t.string   "CreateBy",     limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",     limit: 100
  end

  create_table "order_cancel_managers", primary_key: "ID", force: :cascade do |t|
    t.string   "DepotID",    limit: 36
    t.string   "UserID",     limit: 36
    t.string   "RoleID",     limit: 36
    t.string   "Phone",      limit: 11
    t.datetime "CreateTime"
    t.string   "CreateBy",   limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",   limit: 100
  end

  create_table "order_coupons", primary_key: "ID", force: :cascade do |t|
    t.string   "OrderID",      limit: 36
    t.string   "UserID",       limit: 36
    t.string   "UserCouponID", limit: 36
    t.string   "CouponID",     limit: 36
    t.decimal  "CouponPrice",              precision: 18, scale: 2
    t.datetime "CreateTime"
    t.datetime "UpdateTime"
    t.string   "CreateBy",     limit: 255
    t.string   "UpdateBy",     limit: 255
  end

  add_index "order_coupons", ["CouponID"], name: "index_order_coupons_on_CouponID", using: :btree
  add_index "order_coupons", ["OrderID"], name: "index_order_coupons_on_OrderID", using: :btree
  add_index "order_coupons", ["UserCouponID"], name: "index_order_coupons_on_UserCouponID", using: :btree
  add_index "order_coupons", ["UserID"], name: "index_order_coupons_on_UserID", using: :btree

  create_table "order_group_products", primary_key: "ID", force: :cascade do |t|
    t.string   "OrderID",                 limit: 36
    t.string   "OrderProductID",          limit: 36
    t.string   "ProductID",               limit: 36
    t.string   "SubProductID",            limit: 36
    t.decimal  "Price",                               precision: 18, scale: 2
    t.decimal  "DiscountPrice",                       precision: 18, scale: 2
    t.integer  "Quantity",                limit: 4,                                             null: false
    t.string   "ProductName",             limit: 255
    t.string   "ProductCode",             limit: 255
    t.string   "Specification",           limit: 255
    t.integer  "WarehouseID",             limit: 4
    t.datetime "CreateTime"
    t.string   "CreateBy",                limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",                limit: 100
    t.integer  "RetrunNumber",            limit: 4
    t.integer  "BadNumber",               limit: 4
    t.string   "ShelfRemark",             limit: 255
    t.binary   "IsAppend",                limit: 1,                            default: "b'0'"
    t.decimal  "SMCommissionCoefficient",             precision: 18, scale: 4
    t.integer  "OOSNumber",               limit: 4,                            default: 0
    t.integer  "OperNumber",              limit: 4,                            default: 0
    t.decimal  "MarketingExpense",                    precision: 18, scale: 4, default: 0.0
    t.decimal  "ReceviedExpense",                     precision: 18, scale: 4, default: 0.0
    t.decimal  "PriceProportion",                     precision: 18, scale: 2, default: 0.0
    t.string   "Products_ID",             limit: 36
    t.string   "SubProducts_ID",          limit: 36
    t.decimal  "AvgPurchasePrice",                    precision: 18, scale: 4, default: 0.0
    t.decimal  "MarketingIncome",                     precision: 18, scale: 4, default: 0.0
    t.string   "ProductGroupID",          limit: 36
    t.decimal  "ServicePoint",                        precision: 18, scale: 2
  end

  create_table "order_pay_details", primary_key: "ID", force: :cascade do |t|
    t.string   "OrderID",    limit: 36
    t.integer  "PayType",    limit: 4
    t.decimal  "PayPrice",               precision: 18, scale: 4
    t.datetime "CreateTime"
    t.string   "CreateBy",   limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",   limit: 100
  end

  add_index "order_pay_details", ["OrderID"], name: "idx_orderid", using: :btree

  create_table "order_picking_models", primary_key: "ID", force: :cascade do |t|
    t.string   "CompanyID",      limit: 36
    t.string   "DepotID",        limit: 36
    t.string   "DepotShelfID",   limit: 36
    t.string   "DepotTrayID",    limit: 36
    t.string   "ProductID",      limit: 36
    t.string   "OrderID",        limit: 36
    t.integer  "Number",         limit: 4
    t.date     "ExpirationDate"
    t.integer  "Type",           limit: 4
    t.datetime "CreateTime"
    t.string   "CreateBy",       limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",       limit: 100
    t.string   "DepotShiftID",   limit: 36
    t.string   "Cause",          limit: 255
    t.string   "OrderProductID", limit: 36
  end

  add_index "order_picking_models", ["ID"], name: "ID", using: :btree

  create_table "order_picking_temp_models", primary_key: "ID", force: :cascade do |t|
    t.string   "CompanyID",             limit: 36
    t.string   "DepotID",               limit: 36
    t.string   "DepotShelfID",          limit: 36
    t.string   "DepotTrayID",           limit: 36
    t.string   "ProductID",             limit: 36
    t.string   "OrderID",               limit: 36
    t.integer  "Number",                limit: 4
    t.date     "ExpirationDate"
    t.integer  "Type",                  limit: 4
    t.datetime "CreateTime"
    t.string   "CreateBy",              limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",              limit: 100
    t.string   "DepotShiftID",          limit: 36
    t.string   "Cause",                 limit: 255
    t.string   "FocusOrderPickModelID", limit: 36
    t.string   "groupProductid",        limit: 36
  end

  create_table "order_product_stocks", primary_key: "ID", force: :cascade do |t|
    t.string   "OrderID",             limit: 36
    t.string   "OrderProductID",      limit: 36
    t.string   "ProductID",           limit: 36
    t.string   "SubProductID",        limit: 36
    t.string   "DepotProductStockID", limit: 36
    t.decimal  "Price",                           precision: 18, scale: 2
    t.decimal  "DiscountPrice",                   precision: 18, scale: 2
    t.integer  "Quantity",            limit: 4,                                        null: false
    t.string   "ProductName",         limit: 255
    t.string   "ProductCode",         limit: 255
    t.string   "Specification",       limit: 255
    t.datetime "CreateTime"
    t.string   "CreateBy",            limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",            limit: 100
    t.integer  "RetrunNumber",        limit: 4
    t.integer  "BadNumber",           limit: 4
    t.integer  "OOSNumber",           limit: 4,                            default: 0
  end

  create_table "order_score_tags", primary_key: "ID", force: :cascade do |t|
    t.string   "OrderScoreID", limit: 36
    t.integer  "Type",         limit: 4
    t.string   "Tag",          limit: 255
    t.datetime "CreateTime"
    t.string   "CreateBy",     limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",     limit: 100
  end

  create_table "order_scores", primary_key: "ID", force: :cascade do |t|
    t.string   "OrderID",        limit: 36
    t.integer  "SalesScore",     limit: 4
    t.string   "SalesEvaluate",  limit: 255
    t.integer  "DriverScore",    limit: 4
    t.string   "DriverEvaluate", limit: 255
    t.datetime "CreateTime"
    t.string   "CreateBy",       limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",       limit: 100
  end

  create_table "orderdistributionlogs", primary_key: "ID", force: :cascade do |t|
    t.string   "OrderCode",     limit: 255
    t.string   "ProductID",     limit: 36
    t.string   "operatorCode",  limit: 255
    t.string   "Remark",        limit: 255
    t.integer  "ProductNumber", limit: 4
    t.datetime "CreateTime"
    t.string   "CreateBy",      limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",      limit: 100
  end

  create_table "ordergroups", primary_key: "ID", force: :cascade do |t|
    t.string   "UserID",     limit: 36
    t.integer  "Status",     limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "ordergroups", ["UserID"], name: "index_OrderGroups_on_UserID", using: :btree

  create_table "orderinfo", id: false, force: :cascade do |t|
    t.string  "PayDatetime",            limit: 10
    t.string  "DepotId",                limit: 36
    t.string  "CompanyID",              limit: 36
    t.integer "TotalOrder",             limit: 8,                           default: 0,   null: false
    t.decimal "OrderProductTotalPrice",            precision: 50, scale: 2, default: 0.0, null: false
    t.decimal "GiveawayTotalPrice",                precision: 18, scale: 2, default: 0.0, null: false
    t.decimal "CouponTotalPrice",                  precision: 18, scale: 2, default: 0.0, null: false
    t.decimal "PointTotalPrice",                   precision: 18, scale: 2, default: 0.0, null: false
    t.decimal "LogiTotalPrice",                    precision: 18, scale: 2, default: 0.0, null: false
    t.decimal "TotalMoney",                        precision: 18, scale: 2, default: 0.0, null: false
    t.decimal "TotalReceivedPrice",                precision: 18, scale: 2, default: 0.0, null: false
    t.decimal "TotalOnlinePayDiscount",            precision: 18, scale: 2, default: 0.0, null: false
  end

  create_table "orderlogs", primary_key: "ID", force: :cascade do |t|
    t.string   "OrderId",           limit: 36
    t.integer  "LogType",           limit: 4,          null: false
    t.datetime "OperationDate",                        null: false
    t.string   "OperationItCode",   limit: 255
    t.string   "OperationUserName", limit: 255
    t.text     "Remark",            limit: 4294967295
    t.datetime "CreateTime"
    t.string   "CreateBy",          limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",          limit: 100
    t.string   "IP",                limit: 255
    t.string   "Agent",             limit: 255
    t.integer  "OrderLogType",      limit: 4
  end

  add_index "orderlogs", ["ID"], name: "INDEX_OrderLogs_ON_ID", using: :btree
  add_index "orderlogs", ["OperationDate"], name: "INDEX_OrderLogs_ON_OperationDate", using: :btree
  add_index "orderlogs", ["OrderId"], name: "INDEX_OrderLogs_ON_OrderId", using: :btree

  create_table "orderoosdetailbyeveryday", primary_key: "ID", force: :cascade do |t|
    t.string   "OrderID",            limit: 36
    t.string   "OperationUserNames", limit: 255
    t.datetime "OperationDate"
  end

  create_table "orderpaybyunicomlogs", primary_key: "ID", force: :cascade do |t|
    t.text     "orderCode",      limit: 4294967295
    t.datetime "ConnectionTime"
    t.text     "code",           limit: 4294967295
    t.text     "msg",            limit: 4294967295
    t.text     "type",           limit: 4294967295
    t.datetime "CreateTime"
    t.string   "CreateBy",       limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",       limit: 100
  end

  create_table "orderpaybyunicoms", primary_key: "ID", force: :cascade do |t|
    t.text     "orderCode",     limit: 4294967295
    t.decimal  "receivedPrice",                    precision: 18, scale: 2
    t.text     "trace_no",      limit: 4294967295
    t.text     "refer_no",      limit: 4294967295
    t.text     "bank_card_no",  limit: 4294967295
    t.text     "bank_code",     limit: 4294967295
    t.text     "bank_name",     limit: 4294967295
    t.text     "terminal_id",   limit: 4294967295
    t.text     "mcht_cd",       limit: 4294967295
    t.text     "service",       limit: 4294967295
    t.datetime "CreateTime"
    t.string   "CreateBy",      limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",      limit: 100
  end

  create_table "orderpickdetails", primary_key: "ID", force: :cascade do |t|
    t.string   "OrderID",        limit: 36
    t.string   "ProductID",      limit: 36
    t.string   "DepotTrayID",    limit: 36
    t.datetime "ExpirationDate"
    t.integer  "PickNumber",     limit: 4
    t.datetime "CreateTime"
    t.string   "CreateBy",       limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",       limit: 100
  end

  create_table "orderproductdetails", id: false, force: :cascade do |t|
    t.string  "OrderID",       limit: 36
    t.string  "ProductID",     limit: 36
    t.integer "Quantity",      limit: 8
    t.integer "RetrunNumber",  limit: 8
    t.integer "BadNumber",     limit: 8
    t.integer "OOSNumber",     limit: 8
    t.decimal "Price",                    precision: 20, scale: 4
    t.decimal "DiscountPrice",            precision: 20, scale: 4
  end

  create_table "orderproductdetails2", id: false, force: :cascade do |t|
    t.string  "OrderID",      limit: 36
    t.string  "ProductID",    limit: 36
    t.integer "Quantity",     limit: 4,  default: 0, null: false
    t.integer "RetrunNumber", limit: 4
    t.integer "BadNumber",    limit: 4
    t.integer "OOSNumber",    limit: 4
  end

  create_table "orderproductdetails3", id: false, force: :cascade do |t|
    t.string  "OrderID",      limit: 36
    t.string  "ProductID",    limit: 36
    t.integer "Quantity",     limit: 8
    t.integer "RetrunNumber", limit: 8
    t.integer "BadNumber",    limit: 8
    t.integer "OOSNumber",    limit: 8
  end

  create_table "orderproductdetails4", id: false, force: :cascade do |t|
    t.string  "OrderID",      limit: 36
    t.string  "ProductID",    limit: 36
    t.integer "Quantity",     limit: 4,              null: false
    t.integer "RetrunNumber", limit: 4
    t.integer "BadNumber",    limit: 4
    t.integer "OOSNumber",    limit: 4,  default: 0
  end

  create_table "orderproducts", primary_key: "ID", force: :cascade do |t|
    t.string   "OrderID",                 limit: 36
    t.integer  "Quantity",                limit: 4,                                                                             null: false
    t.string   "ProductName",             limit: 255
    t.string   "ProductCode",             limit: 255
    t.string   "Specification",           limit: 255
    t.integer  "WarehouseID",             limit: 4
    t.decimal  "Price",                               precision: 18, scale: 2
    t.string   "ProductID",               limit: 36
    t.datetime "CreateTime"
    t.string   "CreateBy",                limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",                limit: 100
    t.integer  "RetrunNumber",            limit: 4
    t.integer  "BadNumber",               limit: 4
    t.decimal  "DiscountPrice",                       precision: 18, scale: 2
    t.string   "ShelfRemark",             limit: 255
    t.binary   "IsAppend",                limit: 1,                            default: "b'0'"
    t.decimal  "SMCommissionCoefficient",             precision: 18, scale: 4
    t.integer  "OOSNumber",               limit: 4,                            default: 0
    t.integer  "OperNumber",              limit: 4,                            default: 0
    t.decimal  "MarketingExpense",                    precision: 18, scale: 4, default: 0.0
    t.decimal  "ReceviedExpense",                     precision: 18, scale: 4, default: 0.0
    t.decimal  "PriceProportion",                     precision: 18, scale: 2, default: 0.0
    t.decimal  "AvgPurchasePrice",                    precision: 18, scale: 4, default: 0.0
    t.date     "ExpirationDate"
    t.decimal  "MarketingIncome",                     precision: 18, scale: 4, default: 0.0
    t.boolean  "IsPreSale",               limit: 1,                            default: false
    t.string   "ProductGroupID",          limit: 36
    t.decimal  "ServicePoint",                        precision: 18, scale: 2
    t.string   "DepotId",                 limit: 36,                           default: "00000000-0000-0000-0000-000000000000", null: false
    t.integer  "ConfirmQuantity",         limit: 4,                            default: 0,                                      null: false
  end

  add_index "orderproducts", ["ID"], name: "index_OrderProductsID", using: :btree
  add_index "orderproducts", ["OrderID"], name: "IX_OrderID", using: :btree
  add_index "orderproducts", ["OrderID"], name: "index_OrderProductsOrderID", using: :btree
  add_index "orderproducts", ["ProductID", "OrderID"], name: "IDX_PRODUCTID_ORDERID", using: :btree
  add_index "orderproducts", ["ProductID"], name: "IX_ProductID", using: :btree

  create_table "orders", primary_key: "ID", force: :cascade do |t|
    t.string   "OrderCode",                  limit: 255
    t.string   "Message",                    limit: 255
    t.string   "Address",                    limit: 255
    t.string   "MemberCode",                 limit: 255
    t.decimal  "CostItem",                                      precision: 18, scale: 2
    t.decimal  "GiveawayTotal",                                 precision: 18, scale: 2, default: 0.0
    t.datetime "PayDatetime"
    t.integer  "OrderStatus",                limit: 4
    t.integer  "ShipStatus",                 limit: 4
    t.string   "LogiName",                   limit: 255
    t.string   "LogiCode",                   limit: 255
    t.decimal  "LogiPrice",                                     precision: 18, scale: 2
    t.string   "ShipName",                   limit: 255
    t.string   "ShipTel",                    limit: 255
    t.integer  "PayStatus",                  limit: 4
    t.decimal  "Money",                                         precision: 18, scale: 2
    t.decimal  "PointPrice",                                    precision: 18, scale: 2
    t.integer  "PayType",                    limit: 4
    t.string   "DepotId",                    limit: 36
    t.boolean  "IsHaveInvoice",              limit: 1
    t.string   "InvoiceTitle",               limit: 255
    t.boolean  "OpenedInovie",               limit: 1
    t.decimal  "ReceivedPrice",                                 precision: 18, scale: 2
    t.datetime "CreateTime"
    t.string   "CreateBy",                   limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",                   limit: 100
    t.string   "UserID",                     limit: 36
    t.string   "ReceivePriceType",           limit: 255
    t.text     "ReceivePriceRemark",         limit: 4294967295
    t.string   "CouponCode",                 limit: 36
    t.decimal  "CouponPrice",                                   precision: 18, scale: 2
    t.boolean  "IsUrgency",                  limit: 1
    t.string   "DriverName",                 limit: 255
    t.string   "DriverMobile",               limit: 255
    t.boolean  "IsHaveReturn",               limit: 1
    t.decimal  "Discount",                                      precision: 18, scale: 2, default: 1.0
    t.datetime "SubmitDate"
    t.string   "CountyID",                   limit: 36
    t.string   "CustomerServiceConfirmType", limit: 255
    t.text     "CustomerServiceRemark",      limit: 4294967295
    t.string   "SalesmanID",                 limit: 36
    t.string   "CustomerServiceComment",     limit: 255
    t.decimal  "AppDiscount",                                   precision: 18, scale: 2
    t.string   "FromPlatform",               limit: 255
    t.string   "Longitude",                  limit: 255
    t.string   "Latitude",                   limit: 255
    t.boolean  "Isconfirmation",             limit: 1
    t.datetime "ReceivePriceTime"
    t.decimal  "OnlinePayDiscount",                             precision: 18, scale: 2
    t.integer  "DistributionState",          limit: 4
    t.string   "CompanyID",                  limit: 36
    t.decimal  "Commission",                                    precision: 18, scale: 2
    t.string   "InvitationCode",             limit: 255
    t.integer  "ThirdType",                  limit: 4
    t.datetime "CompletedTime"
    t.integer  "BalanceOfWeek",              limit: 4
    t.string   "RandNum",                    limit: 255
    t.string   "SMUserID",                   limit: 36
    t.decimal  "OriginalMoney",                                 precision: 18, scale: 2, default: 0.0
    t.string   "OrderGroupID",               limit: 36
    t.datetime "SendDate"
    t.datetime "ComfirmTime"
    t.datetime "PrintTime"
    t.datetime "FinanceConfirmTime"
    t.datetime "ReceiveTime"
    t.datetime "ReturnDate"
    t.binary   "IsCalculateExpense",         limit: 1,                                   default: "b'0'"
    t.string   "FaceName",                   limit: 255
    t.string   "CarTypeID",                  limit: 36
    t.date     "ExpirationDate"
    t.boolean  "IsPreSale",                  limit: 1,                                   default: false
    t.string   "SMUserName",                 limit: 255
    t.string   "SMUserMobile",               limit: 255
    t.date     "DeliveryDate"
    t.integer  "DeliveryTime",               limit: 1
    t.integer  "CanceledStatus",             limit: 1
    t.decimal  "CashVolume",                                    precision: 11, scale: 2
    t.string   "PID",                        limit: 36,                                  default: "00000000-0000-0000-0000-000000000000", null: false
    t.string   "SalesmanParentId",           limit: 36
  end

  add_index "orders", ["CreateTime"], name: "index_CreateTime", using: :btree
  add_index "orders", ["DepotId"], name: "IX_DepotId", using: :btree
  add_index "orders", ["ID"], name: "index_OrderID", using: :btree
  add_index "orders", ["OrderCode"], name: "index_OrderCode", using: :btree
  add_index "orders", ["OrderStatus"], name: "IX_OrderStatus", using: :btree
  add_index "orders", ["UserID", "SalesmanID", "SMUserID", "ID"], name: "IDX_US_SA_SM_ID", using: :btree
  add_index "orders", ["UserID"], name: "IX_UserID", using: :btree

  create_table "orderstatisticsbyeveryday", primary_key: "ID", force: :cascade do |t|
    t.date     "OrderDate",                                                                        null: false
    t.decimal  "OrderTotalPrice_Beijing",                   precision: 18, scale: 4
    t.integer  "OrderTotalCount_Beijing",       limit: 4
    t.decimal  "UnitPrice_Beijing",                         precision: 18, scale: 4
    t.decimal  "OrderTotalPrice_Tianjin",                   precision: 18, scale: 4
    t.integer  "OrderTotalCount_Tianjin",       limit: 4
    t.decimal  "UnitPrice_Tianjin",                         precision: 18, scale: 4
    t.decimal  "OrderTotalPrice_Neimeng",                   precision: 18, scale: 4
    t.integer  "OrderTotalCount_Neimeng",       limit: 4
    t.decimal  "UnitPrice_Neimeng",                         precision: 18, scale: 4
    t.decimal  "OrderTotalPrice_Zhengda",                   precision: 18, scale: 4
    t.integer  "OrderTotalCount_Zhengda",       limit: 4
    t.decimal  "UnitPrice_Zhengda",                         precision: 18, scale: 4
    t.decimal  "OrderTotalPrice",                           precision: 18, scale: 4
    t.datetime "CreateTime"
    t.string   "CreateBy",                      limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",                      limit: 100
    t.decimal  "OrderTotalPrice_DavidChoice",               precision: 18, scale: 4, default: 0.0
    t.integer  "OrderTotalCount_DavidChoice",   limit: 4,                            default: 0
    t.decimal  "UnitPrice_DavidChoice",                     precision: 18, scale: 4, default: 0.0
    t.decimal  "OrderTotalPrice_LuZhouLaoJiao",             precision: 18, scale: 4, default: 0.0
    t.integer  "OrderTotalCount_LuZhouLaoJiao", limit: 4,                            default: 0
    t.decimal  "UnitPrice_LuZhouLaoJiao",                   precision: 18, scale: 4, default: 0.0
  end

  create_table "original_order_coupons", primary_key: "ID", force: :cascade do |t|
    t.string   "OrderID",      limit: 36
    t.string   "UserID",       limit: 36
    t.string   "UserCouponID", limit: 36
    t.string   "CouponID",     limit: 36
    t.decimal  "CouponPrice",              precision: 18, scale: 2
    t.datetime "CreateTime"
    t.datetime "UpdateTime"
    t.string   "CreateBy",     limit: 255
    t.string   "UpdateBy",     limit: 255
  end

  add_index "original_order_coupons", ["CouponID"], name: "index_order_coupons_on_CouponID", using: :btree
  add_index "original_order_coupons", ["OrderID"], name: "index_order_coupons_on_OrderID", using: :btree
  add_index "original_order_coupons", ["UserCouponID"], name: "index_order_coupons_on_UserCouponID", using: :btree
  add_index "original_order_coupons", ["UserID"], name: "index_order_coupons_on_UserID", using: :btree

  create_table "original_ordergroups", primary_key: "ID", force: :cascade do |t|
    t.string   "UserID",     limit: 36
    t.integer  "Status",     limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "original_ordergroups", ["UserID"], name: "index_OrderGroups_on_UserID", using: :btree

  create_table "original_orderlogs", primary_key: "ID", force: :cascade do |t|
    t.string   "OrderId",           limit: 36
    t.integer  "LogType",           limit: 4,          null: false
    t.datetime "OperationDate",                        null: false
    t.string   "OperationItCode",   limit: 255
    t.string   "OperationUserName", limit: 255
    t.text     "Remark",            limit: 4294967295
    t.datetime "CreateTime"
    t.string   "CreateBy",          limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",          limit: 100
    t.string   "IP",                limit: 255
    t.string   "Agent",             limit: 255
    t.integer  "OrderLogType",      limit: 4
  end

  add_index "original_orderlogs", ["ID"], name: "INDEX_OrderLogs_ON_ID", using: :btree
  add_index "original_orderlogs", ["OperationDate"], name: "INDEX_OrderLogs_ON_OperationDate", using: :btree
  add_index "original_orderlogs", ["OrderId"], name: "INDEX_OrderLogs_ON_OrderId", using: :btree

  create_table "original_orderproducts", primary_key: "ID", force: :cascade do |t|
    t.string   "OrderID",                 limit: 36
    t.integer  "Quantity",                limit: 4,                                             null: false
    t.string   "ProductName",             limit: 255
    t.string   "ProductCode",             limit: 255
    t.string   "Specification",           limit: 255
    t.integer  "WarehouseID",             limit: 4
    t.decimal  "Price",                               precision: 18, scale: 2
    t.string   "ProductID",               limit: 36
    t.datetime "CreateTime"
    t.string   "CreateBy",                limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",                limit: 100
    t.integer  "RetrunNumber",            limit: 4
    t.integer  "BadNumber",               limit: 4
    t.decimal  "DiscountPrice",                       precision: 18, scale: 2
    t.string   "ShelfRemark",             limit: 255
    t.binary   "IsAppend",                limit: 1,                            default: "b'0'"
    t.decimal  "SMCommissionCoefficient",             precision: 18, scale: 4
    t.integer  "OOSNumber",               limit: 4,                            default: 0
    t.integer  "OperNumber",              limit: 4,                            default: 0
    t.decimal  "MarketingExpense",                    precision: 18, scale: 4, default: 0.0
    t.decimal  "ReceviedExpense",                     precision: 18, scale: 4, default: 0.0
    t.decimal  "PriceProportion",                     precision: 18, scale: 2, default: 0.0
    t.decimal  "AvgPurchasePrice",                    precision: 18, scale: 4, default: 0.0
    t.date     "ExpirationDate"
    t.decimal  "MarketingIncome",                     precision: 18, scale: 4, default: 0.0
    t.boolean  "IsPreSale",               limit: 1,                            default: false
    t.string   "ProductGroupID",          limit: 36
    t.decimal  "ServicePoint",                        precision: 18, scale: 2
  end

  add_index "original_orderproducts", ["ID"], name: "index_OrderProductsID", using: :btree
  add_index "original_orderproducts", ["OrderID"], name: "IX_OrderID", using: :btree
  add_index "original_orderproducts", ["OrderID"], name: "index_OrderProductsOrderID", using: :btree
  add_index "original_orderproducts", ["ProductID"], name: "IX_ProductID", using: :btree

  create_table "original_orders", primary_key: "ID", force: :cascade do |t|
    t.string   "OrderCode",                  limit: 255
    t.string   "Message",                    limit: 255
    t.string   "Address",                    limit: 255
    t.string   "MemberCode",                 limit: 255
    t.decimal  "CostItem",                                      precision: 18, scale: 2
    t.decimal  "GiveawayTotal",                                 precision: 18, scale: 2, default: 0.0
    t.datetime "PayDatetime"
    t.integer  "OrderStatus",                limit: 4
    t.integer  "ShipStatus",                 limit: 4
    t.string   "LogiName",                   limit: 255
    t.string   "LogiCode",                   limit: 255
    t.decimal  "LogiPrice",                                     precision: 18, scale: 2
    t.string   "ShipName",                   limit: 255
    t.string   "ShipTel",                    limit: 255
    t.integer  "PayStatus",                  limit: 4
    t.decimal  "Money",                                         precision: 18, scale: 2
    t.decimal  "PointPrice",                                    precision: 18, scale: 2
    t.integer  "PayType",                    limit: 4
    t.string   "DepotId",                    limit: 36
    t.boolean  "IsHaveInvoice",              limit: 1
    t.string   "InvoiceTitle",               limit: 255
    t.boolean  "OpenedInovie",               limit: 1
    t.decimal  "ReceivedPrice",                                 precision: 18, scale: 2
    t.datetime "CreateTime"
    t.string   "CreateBy",                   limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",                   limit: 100
    t.string   "UserID",                     limit: 36
    t.string   "ReceivePriceType",           limit: 255
    t.text     "ReceivePriceRemark",         limit: 4294967295
    t.string   "CouponCode",                 limit: 36
    t.decimal  "CouponPrice",                                   precision: 18, scale: 2
    t.boolean  "IsUrgency",                  limit: 1
    t.string   "DriverName",                 limit: 255
    t.string   "DriverMobile",               limit: 255
    t.boolean  "IsHaveReturn",               limit: 1
    t.decimal  "Discount",                                      precision: 18, scale: 2, default: 1.0
    t.datetime "SubmitDate"
    t.string   "CountyID",                   limit: 36
    t.string   "CustomerServiceConfirmType", limit: 255
    t.text     "CustomerServiceRemark",      limit: 4294967295
    t.string   "SalesmanID",                 limit: 36
    t.string   "CustomerServiceComment",     limit: 255
    t.decimal  "AppDiscount",                                   precision: 18, scale: 2
    t.string   "FromPlatform",               limit: 255
    t.string   "Longitude",                  limit: 255
    t.string   "Latitude",                   limit: 255
    t.boolean  "Isconfirmation",             limit: 1
    t.datetime "ReceivePriceTime"
    t.decimal  "OnlinePayDiscount",                             precision: 18, scale: 2
    t.integer  "DistributionState",          limit: 4
    t.string   "CompanyID",                  limit: 36
    t.decimal  "Commission",                                    precision: 18, scale: 2
    t.string   "InvitationCode",             limit: 255
    t.integer  "ThirdType",                  limit: 4
    t.datetime "CompletedTime"
    t.integer  "BalanceOfWeek",              limit: 4
    t.string   "RandNum",                    limit: 255
    t.string   "SMUserID",                   limit: 36
    t.decimal  "OriginalMoney",                                 precision: 18, scale: 2, default: 0.0
    t.string   "OrderGroupID",               limit: 36
    t.datetime "SendDate"
    t.datetime "ComfirmTime"
    t.datetime "PrintTime"
    t.datetime "FinanceConfirmTime"
    t.datetime "ReceiveTime"
    t.datetime "ReturnDate"
    t.binary   "IsCalculateExpense",         limit: 1,                                   default: "b'0'"
    t.string   "FaceName",                   limit: 255
    t.string   "CarTypeID",                  limit: 36
    t.date     "ExpirationDate"
    t.boolean  "IsPreSale",                  limit: 1,                                   default: false
    t.string   "SMUserName",                 limit: 255
    t.string   "SMUserMobile",               limit: 255
    t.date     "DeliveryDate"
    t.integer  "DeliveryTime",               limit: 1
    t.integer  "CanceledStatus",             limit: 1
  end

  add_index "original_orders", ["CreateTime"], name: "index_CreateTime", using: :btree
  add_index "original_orders", ["DepotId"], name: "IX_DepotId", using: :btree
  add_index "original_orders", ["ID"], name: "index_OrderID", using: :btree
  add_index "original_orders", ["OrderCode"], name: "index_OrderCode", using: :btree
  add_index "original_orders", ["OrderStatus"], name: "IX_OrderStatus", using: :btree
  add_index "original_orders", ["UserID"], name: "IX_UserID", using: :btree

  create_table "outofstoragedetails", primary_key: "ID", force: :cascade do |t|
    t.integer  "Type",           limit: 4,                                   null: false
    t.string   "InCode",         limit: 255
    t.string   "ProductName",    limit: 255
    t.string   "ProductID",      limit: 36
    t.integer  "ProductCount",   limit: 4
    t.decimal  "ProductPrice",                      precision: 18, scale: 2
    t.text     "OperationType",  limit: 4294967295
    t.string   "StorageName",    limit: 255
    t.string   "DepotId",        limit: 36
    t.string   "OrderId",        limit: 36
    t.integer  "RemainNumber",   limit: 4
    t.datetime "CreateTime"
    t.string   "CreateBy",       limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",       limit: 100
    t.string   "PurchaseID",     limit: 36
    t.string   "DepotShelfID",   limit: 36
    t.string   "ShelfProductID", limit: 36
    t.string   "DepotShiftID",   limit: 36
    t.integer  "OperNumber",     limit: 4
  end

  add_index "outofstoragedetails", ["CreateTime", "DepotId", "OrderId", "PurchaseID"], name: "IDX_CR_DE_OR_PU", using: :btree
  add_index "outofstoragedetails", ["DepotId", "OrderId", "PurchaseID", "ProductID"], name: "IDX_DE_OR_PU_PR", using: :btree
  add_index "outofstoragedetails", ["DepotId"], name: "IX_DepotId", using: :btree
  add_index "outofstoragedetails", ["OrderId"], name: "IX_OrderId", using: :btree
  add_index "outofstoragedetails", ["ProductID", "DepotId"], name: "IDX_PRODUCTID_DEPOTID", using: :btree
  add_index "outofstoragedetails", ["ProductID"], name: "IX_ProductID", using: :btree
  add_index "outofstoragedetails", ["Type"], name: "IX_Type", using: :btree

  create_table "pay_couponlogs", primary_key: "Id", force: :cascade do |t|
    t.string   "OrderCode",    limit: 16,                          null: false
    t.string   "RandomCode",   limit: 16,                          null: false
    t.decimal  "PayMoney",                precision: 10, scale: 2, null: false
    t.string   "UserId",       limit: 36,                          null: false
    t.integer  "PayStatus",    limit: 1,                           null: false
    t.string   "UserCouponId", limit: 36,                          null: false
    t.string   "CouponId",     limit: 36,                          null: false
    t.integer  "CouponStatus", limit: 1,                           null: false
    t.datetime "CreateTime",                                       null: false
    t.datetime "CallBackTime",                                     null: false
    t.datetime "UpdateTime",                                       null: false
    t.string   "BatchNo",      limit: 16,                          null: false
    t.string   "Worker",       limit: 16,                          null: false
  end

  add_index "pay_couponlogs", ["UserId", "BatchNo"], name: "idx_UserId_BatchNo", using: :btree

  create_table "pay_product", primary_key: "Id", force: :cascade do |t|
    t.integer "Pid",           limit: 4,                null: false
    t.string  "ProductName",   limit: 32,               null: false
    t.integer "ProductStatus", limit: 1,                null: false
    t.string  "SuccessUrl",    limit: 512,              null: false
    t.string  "FailUrl",       limit: 512,              null: false
    t.string  "Salt",          limit: 32,               null: false
    t.string  "Remark",        limit: 64,  default: ""
  end

  add_index "pay_product", ["Pid"], name: "un_Pid", unique: true, using: :btree

  create_table "pay_thirdpaydiscountlog", primary_key: "Id", force: :cascade do |t|
    t.string   "OrderCode",      limit: 64,                           null: false
    t.string   "RandomCode",     limit: 64,                           null: false
    t.string   "RequestId",      limit: 128,                          null: false
    t.integer  "PayType",        limit: 1,                            null: false
    t.decimal  "PayAmount",                  precision: 10, scale: 2, null: false
    t.decimal  "DiscountAmount",             precision: 10, scale: 2, null: false
    t.datetime "CreateTime",                                          null: false
  end

  create_table "paylogs", primary_key: "ID", force: :cascade do |t|
    t.string   "OrderID",       limit: 36
    t.integer  "Integral",      limit: 4,   null: false
    t.integer  "Money",         limit: 4,   null: false
    t.integer  "CostPrice",     limit: 4,   null: false
    t.integer  "DiscountPrice", limit: 4,   null: false
    t.integer  "Freight",       limit: 4,   null: false
    t.datetime "CreateTime"
    t.string   "CreateBy",      limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",      limit: 100
  end

  create_table "paysigninfo", primary_key: "Id", force: :cascade do |t|
    t.string   "UserId",     limit: 36, null: false
    t.string   "SignCode",   limit: 32, null: false
    t.string   "OrderCode",  limit: 32, null: false
    t.string   "Random",     limit: 32, null: false
    t.integer  "SignStatus", limit: 1,  null: false
    t.datetime "CreateTime",            null: false
    t.datetime "UpdateTime",            null: false
  end

  add_index "paysigninfo", ["SignCode"], name: "idx_PaySignInfo_SignCode", using: :btree
  add_index "paysigninfo", ["UserId"], name: "idx_PaySignInfo_UserId", unique: true, using: :btree

  create_table "pdaclasslibraries", primary_key: "ID", force: :cascade do |t|
    t.string   "Version",         limit: 255
    t.string   "EquipmentNumber", limit: 255
    t.string   "DepotID",         limit: 36
    t.datetime "CreateTime"
    t.string   "CreateBy",        limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",        limit: 100
  end

  create_table "pointhistories", primary_key: "ID", force: :cascade do |t|
    t.string   "UserID",           limit: 36
    t.integer  "CurrentPoint",     limit: 4,   null: false
    t.integer  "DeltaPoint",       limit: 4,   null: false
    t.integer  "Type",             limit: 4,   null: false
    t.datetime "CreateTime"
    t.string   "CreateBy",         limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",         limit: 100
    t.string   "OrderID",          limit: 36
    t.string   "UserPointBatchID", limit: 36
  end

  create_table "pointlotteries", primary_key: "ID", force: :cascade do |t|
    t.integer  "Type",        limit: 4
    t.string   "TypeName",    limit: 255
    t.decimal  "Percent",                 precision: 18, scale: 4
    t.integer  "Points",      limit: 4
    t.decimal  "CouponPrice",             precision: 18, scale: 2
    t.datetime "CreateTime"
    t.string   "CreateBy",    limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",    limit: 100
    t.decimal  "UseMoney",                precision: 10
    t.integer  "Days",        limit: 4
    t.integer  "Level",       limit: 4
    t.string   "CompanyID",   limit: 36
    t.string   "DepotID",     limit: 36
    t.string   "Logo",        limit: 36
    t.string   "LogoQiNiu",   limit: 36
    t.string   "CouponID",    limit: 36
    t.string   "ProductID",   limit: 36
  end

  create_table "pointlottertstatistics", id: false, force: :cascade do |t|
    t.string   "ID",         limit: 36,  default: "", null: false
    t.string   "DepotID",    limit: 36
    t.string   "OrderID",    limit: 36
    t.string   "UserID",     limit: 36
    t.string   "PrizeName",  limit: 255
    t.datetime "CreateTime"
    t.string   "CreateBy",   limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",   limit: 100
    t.integer  "Type",       limit: 4
    t.string   "ObjectID",   limit: 36
    t.string   "Title",      limit: 255
    t.string   "Phone",      limit: 255
  end

  create_table "pointlotterytemps", primary_key: "ID", force: :cascade do |t|
    t.integer  "Type",        limit: 4
    t.string   "TypeName",    limit: 255
    t.decimal  "Percent",                 precision: 18, scale: 4
    t.integer  "Points",      limit: 4
    t.decimal  "CouponPrice",             precision: 18, scale: 2
    t.boolean  "IsOpen",      limit: 1
    t.datetime "CreateTime"
    t.string   "CreateBy",    limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",    limit: 100
    t.decimal  "UseMoney",                precision: 10
    t.integer  "Days",        limit: 4
    t.integer  "Level",       limit: 4
    t.string   "CompanyID",   limit: 36
    t.string   "DepotID",     limit: 36
    t.string   "Logo",        limit: 36
    t.string   "LogoQiNiu",   limit: 36
    t.string   "CouponID",    limit: 36
    t.string   "ProductID",   limit: 36
  end

  create_table "pointorders", primary_key: "ID", force: :cascade do |t|
    t.string   "UserID",         limit: 36,  null: false
    t.string   "PointProductID", limit: 36
    t.string   "Mobile",         limit: 255
    t.string   "Address",        limit: 255
    t.integer  "Status",         limit: 4
    t.string   "Remark",         limit: 255
    t.datetime "CreateTime"
    t.string   "CreateBy",       limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",       limit: 100
    t.integer  "Point",          limit: 4
    t.string   "Consignee",      limit: 255
    t.integer  "Number",         limit: 4
  end

  create_table "pointproducts", primary_key: "ID", force: :cascade do |t|
    t.string   "Name",              limit: 255
    t.integer  "Type",              limit: 4
    t.boolean  "IsOpen",            limit: 1
    t.integer  "Status",            limit: 4
    t.integer  "Point",             limit: 4
    t.integer  "TotalNumber",       limit: 4
    t.integer  "MaxExchangeNumber", limit: 4
    t.text     "Summary",           limit: 65535
    t.text     "Regulation",        limit: 65535
    t.decimal  "CouponPrice",                     precision: 18, scale: 2
    t.decimal  "CouponUsePrice",                  precision: 18, scale: 2
    t.datetime "CreateTime"
    t.string   "CreateBy",          limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",          limit: 100
    t.integer  "Days",              limit: 4
    t.decimal  "OriginalPrice",                   precision: 18, scale: 4
    t.string   "PhotoID",           limit: 36
    t.string   "CoverQiniu",        limit: 255
  end

  create_table "popup_configs", primary_key: "ID", force: :cascade do |t|
    t.string   "Title",            limit: 255
    t.string   "CityID",           limit: 36
    t.boolean  "IsEnable",         limit: 1
    t.integer  "Priority",         limit: 4
    t.integer  "Condition",        limit: 4
    t.integer  "TriggerCondition", limit: 4
    t.datetime "BeginTime"
    t.datetime "EndTime"
    t.string   "Picture",          limit: 36
    t.string   "PictureQiNiu",     limit: 36
    t.integer  "CouponValidDays",  limit: 4
    t.string   "SkipLink",         limit: 255
    t.decimal  "CouponPrice",                  precision: 18, scale: 2
    t.integer  "Integral",         limit: 4
    t.decimal  "EnablePrice",                  precision: 18, scale: 2
    t.string   "CreateBy",         limit: 100
    t.datetime "CreateTime"
    t.string   "UpdateBy",         limit: 100
    t.datetime "UpdateTime"
    t.string   "GiftBagID",        limit: 36
  end

  create_table "product_manager_backups", primary_key: "ID", force: :cascade do |t|
    t.string   "FrameworkUserID",   limit: 36
    t.string   "ProductID",         limit: 36
    t.string   "DepotID",           limit: 36
    t.integer  "ProductState",      limit: 4
    t.integer  "ProductStockState", limit: 4
    t.integer  "Stock",             limit: 4
    t.integer  "RealStock",         limit: 4
    t.datetime "CreateTime"
    t.string   "CreateBy",          limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",          limit: 100
  end

  create_table "productactivityusers", primary_key: "ID", force: :cascade do |t|
    t.string   "ProductID",  limit: 36,  null: false
    t.string   "UserID",     limit: 36,  null: false
    t.datetime "CreateTime"
    t.string   "CreateBy",   limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",   limit: 100
  end

  create_table "productbrands", primary_key: "ID", force: :cascade do |t|
    t.integer  "BrandCode",  limit: 4
    t.string   "BrandName",  limit: 255
    t.datetime "CreateTime"
    t.string   "CreateBy",   limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",   limit: 100
    t.string   "Logo",       limit: 36
    t.integer  "Level",      limit: 4
    t.string   "LogoQiNiu",  limit: 36
  end

  create_table "productcodeinfoes", primary_key: "ID", force: :cascade do |t|
    t.string   "Code",            limit: 100
    t.integer  "ProductCodeType", limit: 4,   null: false
    t.string   "ProductID",       limit: 36
    t.integer  "Status",          limit: 4,   null: false
    t.datetime "CreateTime"
    t.string   "CreateBy",        limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",        limit: 100
    t.integer  "OperationType",   limit: 4
    t.boolean  "IsDelete",        limit: 1
  end

  add_index "productcodeinfoes", ["Code"], name: "ProductCode_Index", using: :btree
  add_index "productcodeinfoes", ["CreateTime"], name: "Create_Time", using: :btree
  add_index "productcodeinfoes", ["ID"], name: "ID_Index", using: :btree
  add_index "productcodeinfoes", ["IsDelete"], name: "Isdelete", using: :btree
  add_index "productcodeinfoes", ["ProductCodeType"], name: "ProductType_Index", using: :btree
  add_index "productcodeinfoes", ["ProductID", "CreateTime"], name: "ProductID_Index", using: :btree
  add_index "productcodeinfoes", ["UpdateTime"], name: "updatetime", using: :btree

  create_table "productgroup_brands", primary_key: "ID", force: :cascade do |t|
    t.string   "ProductGroupID",   limit: 36
    t.string   "ProductBrandID",   limit: 36
    t.string   "ProductBrandName", limit: 255
    t.datetime "CreateTime"
    t.string   "CreateBy",         limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",         limit: 100
  end

  create_table "productgroups", primary_key: "ID", force: :cascade do |t|
    t.string   "Name",       limit: 255
    t.integer  "Pic",        limit: 4
    t.text     "Describe",   limit: 4294967295
    t.integer  "State",      limit: 4,          null: false
    t.integer  "OrderBy",    limit: 4,          null: false
    t.integer  "Level",      limit: 1
    t.integer  "TagG",       limit: 4
    t.string   "ParentID",   limit: 36
    t.datetime "CreateTime"
    t.string   "CreateBy",   limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",   limit: 100
  end

  create_table "productimgs", primary_key: "ID", force: :cascade do |t|
    t.string   "Name",          limit: 255
    t.string   "Src",           limit: 255
    t.string   "Href",          limit: 255
    t.text     "Describe",      limit: 4294967295
    t.integer  "OrderBy",       limit: 4
    t.string   "ProductInfoID", limit: 36
    t.string   "LSrc",          limit: 255
    t.string   "PhotoID",       limit: 36
    t.datetime "CreateTime"
    t.string   "CreateBy",      limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",      limit: 100
    t.string   "FileQiniuName", limit: 255
  end

  add_index "productimgs", ["PhotoID"], name: "IX_PhotoID", using: :btree
  add_index "productimgs", ["ProductInfoID"], name: "IX_ProductID", using: :btree

  create_table "productinfoaudits", primary_key: "ID", force: :cascade do |t|
    t.string   "Name",                   limit: 255
    t.string   "Code",                   limit: 255
    t.string   "Slogan",                 limit: 255
    t.integer  "State",                  limit: 1
    t.string   "ProductGroupsID",        limit: 36
    t.text     "Show",                   limit: 4294967295
    t.text     "HtmlShow",               limit: 4294967295
    t.string   "Specification",          limit: 255
    t.string   "Unit",                   limit: 255
    t.float    "Weight",                 limit: 24
    t.string   "ProductBrandName",       limit: 255
    t.string   "CoverQiniu",             limit: 255
    t.string   "ProductBrandID",         limit: 36
    t.datetime "CreateTime"
    t.string   "CreateBy",               limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",               limit: 100
    t.decimal  "SaleStandardPrice",                         precision: 18, scale: 2
    t.decimal  "PurchaseStandardPrice",                     precision: 18, scale: 4
    t.integer  "Type",                   limit: 4
    t.string   "CompanyID",              limit: 36
    t.decimal  "ServicePoint",                              precision: 18, scale: 2
    t.decimal  "Commission",                                precision: 18, scale: 2
    t.integer  "Status",                 limit: 4
    t.string   "FinancialSecondLevelID", limit: 36
    t.float    "Length",                 limit: 24
    t.float    "width",                  limit: 24
    t.float    "height",                 limit: 24
    t.string   "OldCode",                limit: 100,                                 default: ""
    t.integer  "Shelflife",              limit: 4,                                                null: false
    t.integer  "ForbidTheSale",          limit: 4,                                   default: 1,  null: false
    t.string   "ProductInfoID",          limit: 36
  end

  add_index "productinfoaudits", ["Code"], name: "IX_Code", using: :btree
  add_index "productinfoaudits", ["ID"], name: "IX_ID", using: :btree
  add_index "productinfoaudits", ["Name"], name: "IX_Name", using: :btree
  add_index "productinfoaudits", ["ProductGroupsID"], name: "IX_ProductGroupsID", using: :btree

  create_table "productinfoaudits_copy", primary_key: "ID", force: :cascade do |t|
    t.string   "Name",                   limit: 255
    t.string   "Code",                   limit: 255
    t.string   "Slogan",                 limit: 255
    t.integer  "State",                  limit: 1
    t.string   "ProductGroupsID",        limit: 36
    t.text     "Show",                   limit: 4294967295
    t.text     "HtmlShow",               limit: 4294967295
    t.string   "Specification",          limit: 255
    t.string   "Unit",                   limit: 255
    t.float    "Weight",                 limit: 24
    t.string   "ProductBrandName",       limit: 255
    t.string   "CoverQiniu",             limit: 255
    t.string   "ProductBrandID",         limit: 36
    t.datetime "CreateTime"
    t.string   "CreateBy",               limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",               limit: 100
    t.decimal  "SaleStandardPrice",                         precision: 18, scale: 2
    t.decimal  "PurchaseStandardPrice",                     precision: 18, scale: 4
    t.integer  "Type",                   limit: 4
    t.string   "CompanyID",              limit: 36
    t.decimal  "ServicePoint",                              precision: 18, scale: 2
    t.decimal  "Commission",                                precision: 18, scale: 2
    t.integer  "Status",                 limit: 4
    t.string   "FinancialSecondLevelID", limit: 36
    t.float    "Length",                 limit: 24
    t.float    "width",                  limit: 24
    t.float    "height",                 limit: 24
    t.string   "OldCode",                limit: 100,                                 default: ""
    t.integer  "Shelflife",              limit: 4,                                                null: false
    t.integer  "ForbidTheSale",          limit: 4,                                   default: 1,  null: false
    t.string   "ProductInfoID",          limit: 36
  end

  add_index "productinfoaudits_copy", ["Code"], name: "IX_Code", using: :btree
  add_index "productinfoaudits_copy", ["ID"], name: "IX_ID", using: :btree
  add_index "productinfoaudits_copy", ["Name"], name: "IX_Name", using: :btree
  add_index "productinfoaudits_copy", ["ProductGroupsID"], name: "IX_ProductGroupsID", using: :btree

  create_table "productinfoeaudits", primary_key: "ID", force: :cascade do |t|
    t.string   "Name",                   limit: 255
    t.string   "Code",                   limit: 255
    t.string   "Slogan",                 limit: 255
    t.integer  "State",                  limit: 1
    t.string   "ProductGroupsID",        limit: 36
    t.text     "Show",                   limit: 4294967295
    t.text     "HtmlShow",               limit: 4294967295
    t.string   "Specification",          limit: 255
    t.string   "Unit",                   limit: 255
    t.float    "Weight",                 limit: 24
    t.string   "ProductBrandName",       limit: 255
    t.string   "CoverQiniu",             limit: 255
    t.string   "ProductBrandID",         limit: 36
    t.datetime "CreateTime"
    t.string   "CreateBy",               limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",               limit: 100
    t.decimal  "SaleStandardPrice",                         precision: 18, scale: 2
    t.decimal  "PurchaseStandardPrice",                     precision: 18, scale: 4
    t.integer  "Type",                   limit: 4
    t.string   "CompanyID",              limit: 36
    t.decimal  "ServicePoint",                              precision: 18, scale: 2
    t.decimal  "Commission",                                precision: 18, scale: 2
    t.integer  "Status",                 limit: 4
    t.string   "FinancialSecondLevelID", limit: 36
    t.float    "Length",                 limit: 24
    t.float    "width",                  limit: 24
    t.float    "height",                 limit: 24
    t.string   "OldCode",                limit: 100,                                 default: ""
    t.integer  "Shelflife",              limit: 4,                                                null: false
    t.integer  "ForbidTheSale",          limit: 4,                                   default: 1,  null: false
  end

  create_table "productinfoes", primary_key: "ID", force: :cascade do |t|
    t.string   "Name",                   limit: 255
    t.string   "Code",                   limit: 255
    t.string   "Slogan",                 limit: 255
    t.integer  "State",                  limit: 1
    t.string   "ProductGroupsID",        limit: 36
    t.text     "Show",                   limit: 4294967295
    t.text     "HtmlShow",               limit: 4294967295
    t.string   "Specification",          limit: 255
    t.string   "Unit",                   limit: 255
    t.float    "Weight",                 limit: 24
    t.string   "ProductBrandName",       limit: 255
    t.string   "CoverQiniu",             limit: 255
    t.string   "ProductBrandID",         limit: 36
    t.datetime "CreateTime"
    t.string   "CreateBy",               limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",               limit: 100
    t.decimal  "SaleStandardPrice",                         precision: 18, scale: 2
    t.decimal  "PurchaseStandardPrice",                     precision: 18, scale: 4
    t.integer  "Type",                   limit: 4
    t.string   "CompanyID",              limit: 36
    t.decimal  "ServicePoint",                              precision: 18, scale: 2
    t.decimal  "Commission",                                precision: 18, scale: 2
    t.integer  "Status",                 limit: 4
    t.string   "FinancialSecondLevelID", limit: 36
    t.float    "Length",                 limit: 24
    t.float    "width",                  limit: 24
    t.float    "height",                 limit: 24
    t.string   "OldCode",                limit: 100,                                 default: ""
    t.integer  "Shelflife",              limit: 4,                                                null: false
    t.integer  "ForbidTheSale",          limit: 4,                                   default: 1,  null: false
  end

  add_index "productinfoes", ["Code"], name: "IX_Code", using: :btree
  add_index "productinfoes", ["ID"], name: "IX_ID", using: :btree
  add_index "productinfoes", ["Name"], name: "IX_Name", using: :btree
  add_index "productinfoes", ["ProductGroupsID"], name: "IX_ProductGroupsID", using: :btree

  create_table "productinfologs", primary_key: "ID", force: :cascade do |t|
    t.string   "ProductInfoID", limit: 36
    t.integer  "Status",        limit: 4
    t.string   "Remark",        limit: 255
    t.datetime "CreateTime"
    t.string   "CreateBy",      limit: 100
    t.string   "IP",            limit: 255
    t.string   "Agent",         limit: 255
    t.datetime "UpdateTime"
    t.string   "UpdateBy",      limit: 100
  end

  create_table "productinfopricelogs", primary_key: "ID", force: :cascade do |t|
    t.string   "ProductInfoPriceID", limit: 36
    t.integer  "Type",               limit: 4
    t.string   "Remark",             limit: 255
    t.string   "IP",                 limit: 255
    t.string   "Agent",              limit: 255
    t.datetime "CreateTime"
    t.string   "CreateBy",           limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",           limit: 100
  end

  create_table "productinfoprices", primary_key: "ID", force: :cascade do |t|
    t.string   "ProductInfoID", limit: 36
    t.decimal  "Price",                     precision: 18, scale: 4
    t.decimal  "ServicePoint",              precision: 18, scale: 2
    t.decimal  "PurchasePrice",             precision: 18, scale: 4
    t.datetime "EffectiveDate"
    t.integer  "Status",        limit: 4
    t.string   "Remark",        limit: 255
    t.datetime "CreateTime"
    t.string   "CreateBy",      limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",      limit: 100
  end

  create_table "productlogs", primary_key: "ID", force: :cascade do |t|
    t.string   "Name",                    limit: 100
    t.string   "Code",                    limit: 100,                                 default: ""
    t.string   "Slogan",                  limit: 255
    t.integer  "State",                   limit: 1
    t.integer  "OrderBy",                 limit: 4
    t.integer  "Tag",                     limit: 4
    t.string   "ProductGroupsID",         limit: 36
    t.text     "Show",                    limit: 4294967295
    t.integer  "Recommend",               limit: 4
    t.text     "Describe",                limit: 4294967295
    t.string   "Specification",           limit: 255
    t.decimal  "ProductPrice",                               precision: 18, scale: 4
    t.string   "Unit",                    limit: 255
    t.integer  "Weight",                  limit: 4
    t.string   "PhotoID",                 limit: 36
    t.decimal  "ServicePoint",                               precision: 18, scale: 2
    t.datetime "CreateTime"
    t.string   "CreateBy",                limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",                limit: 100
    t.text     "HtmlShow",                limit: 4294967295
    t.decimal  "OriginalPrice",                              precision: 18, scale: 4
    t.string   "ProductBrandName",        limit: 255
    t.decimal  "PurchasePrice",                              precision: 18, scale: 4
    t.string   "Cover",                   limit: 255
    t.string   "CoverQiniu",              limit: 255
    t.decimal  "MovingAverage",                              precision: 18, scale: 4
    t.integer  "Type",                    limit: 4,                                   default: 0
    t.string   "ProductBrandID",          limit: 36
    t.integer  "MaxSaleAmount",           limit: 4,                                   default: 0
    t.integer  "Source",                  limit: 4
    t.decimal  "OrderProductCost",                           precision: 18, scale: 4
    t.integer  "RecommendOrderBy",        limit: 4
    t.integer  "MaxActivityAmount",       limit: 4
    t.datetime "ActivityBeginTime"
    t.datetime "ActivityEndTime"
    t.integer  "CurrentActivityAmount",   limit: 4
    t.string   "CompanyID",               limit: 36
    t.string   "ProductInfoID",           limit: 36
    t.integer  "MaxSaleAmountDay",        limit: 4
    t.decimal  "SMCommissionCoefficient",                    precision: 18, scale: 4, default: 0.01
    t.integer  "RecommendSort",           limit: 4
    t.integer  "ThirdType",               limit: 4,                                   default: 0
    t.integer  "StockUnderNumber",        limit: 4,                                   default: 0
    t.integer  "StockReplenishNumber",    limit: 4,                                   default: 0
    t.integer  "MinBuyCount",             limit: 4
    t.string   "ProductManagerID",        limit: 36
    t.string   "OldCode",                 limit: 100,                                 default: ""
    t.decimal  "DiscountRate",                               precision: 18, scale: 2
    t.string   "CornerMark",              limit: 20
    t.integer  "SaleCountBySevenDays",    limit: 4
    t.string   "ProductID",               limit: 36
    t.string   "Remark",                  limit: 255
  end

  add_index "productlogs", ["Code"], name: "index_ProductsCODE", using: :btree
  add_index "productlogs", ["Name"], name: "index_ProductsNAME", using: :btree
  add_index "productlogs", ["PhotoID"], name: "IX_PhotoID", using: :btree
  add_index "productlogs", ["ProductGroupsID"], name: "IX_ProductGroupsID", using: :btree
  add_index "productlogs", ["ProductInfoID", "ID"], name: "IDX_PRODUCTINFOID_ID", using: :btree
  add_index "productlogs", ["ProductInfoID"], name: "IX_PorductInfo", using: :btree

  create_table "productpricelogs", primary_key: "ID", force: :cascade do |t|
    t.string   "ProductPriceID", limit: 36
    t.integer  "Type",           limit: 4
    t.string   "Remark",         limit: 255
    t.string   "IP",             limit: 255
    t.string   "Agent",          limit: 255
    t.datetime "CreateTime"
    t.string   "CreateBy",       limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",       limit: 100
  end

  create_table "productprices", primary_key: "ID", force: :cascade do |t|
    t.string   "ProductID",           limit: 36
    t.decimal  "Price",                           precision: 18, scale: 4
    t.decimal  "ServicePoint",                    precision: 18, scale: 2
    t.decimal  "OriginalPrice",                   precision: 18, scale: 4
    t.decimal  "PurchasePrice",                   precision: 18, scale: 4
    t.datetime "EffectiveDate"
    t.integer  "Status",              limit: 4
    t.string   "Remark",              limit: 255
    t.datetime "CreateTime"
    t.string   "CreateBy",            limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",            limit: 100
    t.integer  "IsTimingEffect",      limit: 1
    t.datetime "EffectTime"
    t.string   "BatchProductPriceID", limit: 36
  end

  create_table "productrecommend_hfloors", id: false, force: :cascade do |t|
    t.string   "ID",                 limit: 36
    t.string   "ProductRecommendID", limit: 36
    t.string   "FloorName",          limit: 255
    t.integer  "Sort",               limit: 4
    t.datetime "CreateTime"
    t.string   "CreateBy",           limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",           limit: 100
  end

  create_table "productrecommendinfodetails", primary_key: "ID", force: :cascade do |t|
    t.string   "ProductRecommendInfoID", limit: 36
    t.string   "ProductID",              limit: 36
    t.string   "ProductName",            limit: 255
    t.integer  "OrderBy",                limit: 4,   default: 1000
    t.string   "ProductCode",            limit: 255
    t.string   "Unit",                   limit: 255
    t.string   "Specification",          limit: 255
    t.datetime "CreateTime"
    t.string   "CreateBy",               limit: 255
    t.datetime "UpdateTime"
    t.string   "UpdateBy",               limit: 255
  end

  create_table "productrecommendinfoes", primary_key: "ID", force: :cascade do |t|
    t.string   "RecommendCode",        limit: 255
    t.string   "RecommendName",        limit: 255
    t.integer  "ProductRecommendType", limit: 4
    t.integer  "OrderBy",              limit: 4
    t.string   "Link",                 limit: 255
    t.string   "ViceRecommendName",    limit: 255
    t.datetime "CreateTime"
    t.string   "CreateBy",             limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",             limit: 100
    t.string   "PhotoID",              limit: 36
    t.string   "CompanyID",            limit: 36
    t.integer  "Template",             limit: 4
    t.boolean  "IsEnabled",            limit: 1
    t.string   "BackgroundColor",      limit: 100
    t.boolean  "IsSeckill",            limit: 1
  end

  create_table "products", primary_key: "ID", force: :cascade do |t|
    t.string   "Name",                    limit: 100,                                                null: false
    t.string   "Code",                    limit: 100,                                 default: "",   null: false
    t.string   "Slogan",                  limit: 255
    t.integer  "State",                   limit: 1
    t.integer  "OrderBy",                 limit: 4
    t.integer  "Tag",                     limit: 4
    t.string   "ProductGroupsID",         limit: 36
    t.text     "Show",                    limit: 4294967295
    t.integer  "Recommend",               limit: 4
    t.text     "Describe",                limit: 4294967295
    t.string   "Specification",           limit: 255
    t.decimal  "ProductPrice",                               precision: 18, scale: 4
    t.string   "Unit",                    limit: 255
    t.integer  "Weight",                  limit: 4
    t.string   "PhotoID",                 limit: 36
    t.decimal  "ServicePoint",                               precision: 18, scale: 2
    t.datetime "CreateTime"
    t.string   "CreateBy",                limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",                limit: 100
    t.text     "HtmlShow",                limit: 4294967295
    t.decimal  "OriginalPrice",                              precision: 18, scale: 4
    t.string   "ProductBrandName",        limit: 255
    t.decimal  "PurchasePrice",                              precision: 18, scale: 4
    t.string   "Cover",                   limit: 255
    t.string   "CoverQiniu",              limit: 255
    t.decimal  "MovingAverage",                              precision: 18, scale: 4
    t.integer  "Type",                    limit: 4,                                   default: 0
    t.string   "ProductBrandID",          limit: 36
    t.integer  "MaxSaleAmount",           limit: 4,                                   default: 0
    t.integer  "Source",                  limit: 4
    t.decimal  "OrderProductCost",                           precision: 18, scale: 4
    t.integer  "RecommendOrderBy",        limit: 4
    t.integer  "MaxActivityAmount",       limit: 4,                                                  null: false
    t.datetime "ActivityBeginTime"
    t.datetime "ActivityEndTime"
    t.integer  "CurrentActivityAmount",   limit: 4
    t.string   "CompanyID",               limit: 36
    t.string   "ProductInfoID",           limit: 36
    t.integer  "MaxSaleAmountDay",        limit: 4
    t.decimal  "SMCommissionCoefficient",                    precision: 18, scale: 4, default: 0.01
    t.integer  "RecommendSort",           limit: 4
    t.integer  "ThirdType",               limit: 4,                                   default: 0
    t.integer  "StockUnderNumber",        limit: 4,                                   default: 0
    t.integer  "StockReplenishNumber",    limit: 4,                                   default: 0
    t.integer  "MinBuyCount",             limit: 4
    t.string   "ProductManagerID",        limit: 36
    t.string   "OldCode",                 limit: 100,                                 default: ""
    t.decimal  "DiscountRate",                               precision: 18, scale: 2
    t.string   "CornerMark",              limit: 20
    t.integer  "SaleCountBySevenDays",    limit: 4
    t.integer  "SellState",               limit: 4
  end

  add_index "products", ["Code"], name: "index_ProductsCODE", using: :btree
  add_index "products", ["Name"], name: "index_ProductsNAME", using: :btree
  add_index "products", ["PhotoID"], name: "IX_PhotoID", using: :btree
  add_index "products", ["ProductGroupsID"], name: "IX_ProductGroupsID", using: :btree
  add_index "products", ["ProductInfoID", "ID"], name: "IDX_PRODUCTINFOID_ID", using: :btree
  add_index "products", ["ProductInfoID"], name: "IX_PorductInfo", using: :btree

  create_table "productstockbackups", primary_key: "ID", force: :cascade do |t|
    t.string   "CompanyID",        limit: 36
    t.string   "CompanyName",      limit: 255
    t.string   "DepotID",          limit: 36
    t.string   "DepotName",        limit: 255
    t.string   "ProductID",        limit: 36
    t.string   "ProductCode",      limit: 255
    t.integer  "Stock",            limit: 4
    t.integer  "RealStock",        limit: 4
    t.integer  "OzyNumber",        limit: 4
    t.integer  "GzyNumber",        limit: 4
    t.decimal  "AvgPurchasePrice",             precision: 18, scale: 4
    t.string   "BackupDate",       limit: 255
    t.datetime "CreateTime"
    t.string   "CreateBy",         limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",         limit: 100
  end

  add_index "productstockbackups", ["ProductID", "DepotID"], name: "IDX_PRODUCTID_DEPOTID", using: :btree

  create_table "productstocklogs", primary_key: "ID", force: :cascade do |t|
    t.string   "DataID",       limit: 36
    t.string   "ProductCode",  limit: 255
    t.string   "ProductName",  limit: 255
    t.integer  "ChangeNumber", limit: 4
    t.string   "Unit",         limit: 255
    t.integer  "ChangeType",   limit: 4,   null: false
    t.string   "IP",           limit: 255
    t.string   "Agent",        limit: 255
    t.datetime "CreateTime"
    t.string   "CreateBy",     limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",     limit: 100
    t.string   "DataDetailID", limit: 36
    t.string   "ProductID",    limit: 36
    t.integer  "BeforeNumber", limit: 4
    t.string   "DepotID",      limit: 36
    t.string   "DutyPerson",   limit: 255
    t.string   "Cause",        limit: 255
  end

  add_index "productstocklogs", ["CreateTime"], name: "index_CreateTime", using: :btree
  add_index "productstocklogs", ["DataID"], name: "index_DataID", using: :btree
  add_index "productstocklogs", ["DepotID"], name: "index_Depot", using: :btree
  add_index "productstocklogs", ["DepotID"], name: "index_DepotID", using: :btree
  add_index "productstocklogs", ["ProductCode"], name: "index_ProductCode", using: :btree
  add_index "productstocklogs", ["ProductID"], name: "index_ProductID", using: :btree
  add_index "productstocklogs", ["ProductName"], name: "index_ProductName", using: :btree

  create_table "productstocks", primary_key: "ID", force: :cascade do |t|
    t.string   "ProductID",           limit: 36
    t.string   "DepotID",             limit: 36
    t.integer  "Stock",               limit: 4
    t.integer  "PreSaleQuantity",     limit: 4,                            default: 0
    t.decimal  "BeforePurchasePrice",             precision: 18, scale: 4
    t.integer  "State",               limit: 4
    t.string   "CreateBy",            limit: 100
    t.datetime "CreateTime"
    t.datetime "UpdateTime"
    t.string   "UpdateBy",            limit: 100
    t.integer  "AddStock",            limit: 4
    t.integer  "SubtractStock",       limit: 4
    t.integer  "AlertPercentMin",     limit: 4,                            default: 0
    t.integer  "AlertPercentMax",     limit: 4,                            default: 0
    t.integer  "ActivityNum",         limit: 4,                            default: 0
    t.integer  "AddActivityNum",      limit: 4
    t.integer  "SubActivityNum",      limit: 4
  end

  create_table "producttaggroups", primary_key: "ID", force: :cascade do |t|
    t.string   "ProductInfoID", limit: 36
    t.string   "TagID",         limit: 36
    t.datetime "CreateTime"
    t.string   "CreateBy",      limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",      limit: 100
  end

  add_index "producttaggroups", ["ProductInfoID"], name: "IX_ProductID", using: :btree
  add_index "producttaggroups", ["TagID"], name: "IX_TagID", using: :btree

  create_table "provinces", primary_key: "ID", force: :cascade do |t|
    t.string   "ProvinceName", limit: 255, null: false
    t.string   "ProvinceNo",   limit: 255, null: false
    t.datetime "CreateTime"
    t.string   "CreateBy",     limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",     limit: 100
    t.string   "CompanyID",    limit: 36
  end

  create_table "purchaseauditfrees", primary_key: "ID", force: :cascade do |t|
    t.string   "ParentID",   limit: 36
    t.text     "Name",       limit: 4294967295
    t.text     "Code",       limit: 4294967295
    t.datetime "CreateTime"
    t.string   "CreateBy",   limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",   limit: 100
  end

  create_table "purchasedetails", primary_key: "ID", force: :cascade do |t|
    t.string   "ProductName",          limit: 255
    t.decimal  "ProductTotalPrice",                precision: 18, scale: 4
    t.decimal  "ProductPrice",                     precision: 18, scale: 4
    t.datetime "ValidityPeriod"
    t.integer  "ProductNumber",        limit: 4
    t.integer  "ReceivedNumber",       limit: 4,                                           null: false
    t.integer  "OperNumber",           limit: 4,                                           null: false
    t.string   "ProductID",            limit: 36
    t.string   "PurchaseID",           limit: 36
    t.datetime "CreateTime"
    t.string   "CreateBy",             limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",             limit: 100
    t.string   "unit",                 limit: 255
    t.integer  "ReturnCount",          limit: 4
    t.string   "ReturnPurchases_ID",   limit: 36
    t.datetime "ExpirationDate"
    t.string   "ShelfName",            limit: 255
    t.decimal  "BeforePurchasePrice",              precision: 10, scale: 2
    t.integer  "Stock",                limit: 4
    t.integer  "XsNumber",             limit: 4
    t.decimal  "ServicePoint",                     precision: 18, scale: 2, default: 0.17
    t.string   "DepotShelfID",         limit: 36
    t.string   "DepotTrayID",          limit: 36
    t.string   "Specification",        limit: 255
    t.decimal  "ModifyProductPrice",               precision: 18, scale: 4
    t.integer  "ModifyReceivedNumber", limit: 4
  end

  add_index "purchasedetails", ["ProductID"], name: "IX_ProductID", using: :btree
  add_index "purchasedetails", ["PurchaseID"], name: "IX_PurchaseID", using: :btree

  create_table "purchasedetailsmodifies", primary_key: "ID", force: :cascade do |t|
    t.string   "PurchaseModifiesID",       limit: 36
    t.string   "PurchaseDetailsID",        limit: 36
    t.integer  "OldReceivedNumber",        limit: 4
    t.decimal  "OldProductPrice",                      precision: 18, scale: 4
    t.integer  "ModifyReceivedNumber",     limit: 4
    t.integer  "DifferenceReceivedNumber", limit: 4
    t.decimal  "ModifyProductPrice",                   precision: 18, scale: 4
    t.decimal  "DifferenceProductPrice",               precision: 18, scale: 4
    t.string   "ProductID",                limit: 36
    t.string   "ProductName",              limit: 255
    t.string   "ProductCode",              limit: 255
    t.string   "OldDepotShelfID",          limit: 36
    t.string   "OldDepotTrayID",           limit: 36
    t.datetime "OldExpirationDate"
    t.datetime "CreateTime"
    t.string   "CreateBy",                 limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",                 limit: 100
  end

  create_table "purchaseidentifications", primary_key: "ID", force: :cascade do |t|
    t.string   "PurchaseID",     limit: 36
    t.text     "Identification", limit: 4294967295
    t.string   "DepotShiftID",   limit: 36
    t.integer  "OperationType",  limit: 4
    t.datetime "CreateTime"
    t.string   "CreateBy",       limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",       limit: 100
  end

  create_table "purchaselogs", primary_key: "ID", force: :cascade do |t|
    t.string   "PurchaseID", limit: 36
    t.string   "Content",    limit: 255
    t.string   "Remark",     limit: 255
    t.string   "IP",         limit: 255
    t.string   "Agent",      limit: 255
    t.datetime "CreateTime"
    t.string   "CreateBy",   limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",   limit: 100
    t.integer  "Type",       limit: 4
    t.string   "FileID",     limit: 36
  end

  create_table "purchasemodifies", primary_key: "ID", force: :cascade do |t|
    t.string   "PurchaseID",                         limit: 36
    t.string   "Code",                               limit: 255
    t.integer  "Status",                             limit: 4
    t.integer  "Type",                               limit: 4
    t.string   "Cause",                              limit: 255
    t.datetime "CreateTime"
    t.string   "CreateBy",                           limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",                           limit: 100
    t.string   "depottrayproductstock_adjustmentID", limit: 36
    t.boolean  "IsDeleted",                          limit: 1
  end

  create_table "purchasemodifylogs", primary_key: "ID", force: :cascade do |t|
    t.string   "PurchaseModifiesID", limit: 36
    t.integer  "Status",             limit: 4
    t.string   "Remark",             limit: 255
    t.string   "IP",                 limit: 255
    t.string   "Agent",              limit: 255
    t.datetime "CreateTime"
    t.string   "CreateBy",           limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",           limit: 100
  end

  create_table "purchasemodifyrelations", primary_key: "ID", force: :cascade do |t|
    t.string   "MofifyPurchaseID", limit: 36
    t.string   "OldPurchaseID",    limit: 36
    t.string   "ReturnOrderID",    limit: 36
    t.string   "ReturnPurchaseID", limit: 36
    t.string   "NewPurchaseID",    limit: 36
    t.string   "OutOrderID",       limit: 36
    t.integer  "Type",             limit: 4
    t.string   "CreateBy",         limit: 255
    t.datetime "CreateTime"
    t.string   "UpdateBy",         limit: 255
    t.datetime "UpdateTime"
  end

  create_table "purchasepaydetails", primary_key: "ID", force: :cascade do |t|
    t.string   "PurchaseID", limit: 36
    t.datetime "PayTime"
    t.string   "PayCode",    limit: 255
    t.integer  "PayType",    limit: 4
    t.decimal  "PayNumber",              precision: 18, scale: 2
    t.string   "Content",    limit: 255
    t.string   "IP",         limit: 255
    t.string   "Agent",      limit: 255
    t.datetime "CreateTime"
    t.string   "CreateBy",   limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",   limit: 100
  end

  create_table "purchases", primary_key: "ID", force: :cascade do |t|
    t.string   "PurchaseCode",        limit: 255
    t.string   "Title",               limit: 255
    t.datetime "SendDate"
    t.integer  "Status",              limit: 4
    t.integer  "Shipstatus",          limit: 4
    t.text     "Remark",              limit: 4294967295
    t.text     "AuditMsg",            limit: 4294967295
    t.string   "DepotID",             limit: 36
    t.datetime "CreateTime"
    t.string   "CreateBy",            limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",            limit: 100
    t.string   "SupplierID",          limit: 36
    t.string   "SupplierName",        limit: 255
    t.string   "Address",             limit: 255
    t.string   "AccountName",         limit: 255
    t.string   "AccountBank",         limit: 255
    t.string   "AccountNumber",       limit: 255
    t.decimal  "PurchasePrice",                          precision: 18, scale: 4
    t.integer  "InvoiceType",         limit: 4
    t.decimal  "TaxRate",                                precision: 18, scale: 4
    t.decimal  "TotalPurchase",                          precision: 18, scale: 4
    t.decimal  "Tax",                                    precision: 18, scale: 4
    t.decimal  "Total",                                  precision: 18, scale: 4
    t.integer  "PayType",             limit: 4
    t.string   "InvoiceNo",           limit: 255
    t.integer  "NumberNehicles",      limit: 4
    t.decimal  "DeductionPrice",                         precision: 18, scale: 4
    t.string   "CompanyID",           limit: 36
    t.decimal  "YFMoney",                                precision: 18, scale: 4
    t.binary   "IsSaleSyProxy",       limit: 1
    t.binary   "IsAuditFree",         limit: 1
    t.binary   "IsReceiveInvoice",    limit: 1
    t.datetime "ConfirmReceiptTime"
    t.decimal  "ModifyYFMoney",                          precision: 18, scale: 4
    t.decimal  "ModifyPurchasePrice",                    precision: 18, scale: 4
  end

  add_index "purchases", ["DepotID"], name: "IX_DepotID", using: :btree
  add_index "purchases", ["ID"], name: "index_PurchasesID", using: :btree
  add_index "purchases", ["SupplierID"], name: "IX_SupplierID", using: :btree

  create_table "recommend_config_products", primary_key: "ID", force: :cascade do |t|
    t.string   "RecommendConfigID", limit: 36
    t.string   "ProductID",         limit: 36
    t.datetime "CreateTime"
    t.string   "CreateBy",          limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",          limit: 100
    t.string   "CompanyName",       limit: 100
    t.string   "ProductName",       limit: 100
    t.string   "ProductCode",       limit: 100
    t.string   "ProductGroup",      limit: 100
    t.string   "Unit",              limit: 100
    t.string   "Brand",             limit: 100
    t.string   "State",             limit: 100
    t.integer  "Sort",              limit: 4
  end

  create_table "recommend_configs", primary_key: "ID", force: :cascade do |t|
    t.string   "CompanyID",      limit: 36
    t.string   "ProductGroupID", limit: 36
    t.datetime "BeginDate"
    t.datetime "EndDate"
    t.datetime "CreateTime"
    t.string   "CreateBy",       limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",       limit: 100
  end

  create_table "returnpurchasedetails", primary_key: "ID", force: :cascade do |t|
    t.string   "ReturnPurchasesID", limit: 36
    t.string   "ProductName",       limit: 255
    t.string   "ProductCode",       limit: 255
    t.string   "ProductID",         limit: 36
    t.integer  "ReturnCount",       limit: 4
    t.integer  "SjReturnCount",     limit: 4
    t.string   "Unit",              limit: 255
    t.datetime "CreateTime"
    t.string   "CreateBy",          limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",          limit: 100
    t.decimal  "RetrunPrice",                   precision: 18, scale: 4
    t.string   "PurchaseDetailID",  limit: 36
    t.integer  "OperNumber",        limit: 4
    t.string   "DepotShelfID",      limit: 36
    t.string   "DepotTrayID",       limit: 36
  end

  create_table "returnpurchaselogs", primary_key: "ID", force: :cascade do |t|
    t.string   "ReturnPurchasesID", limit: 36
    t.string   "Content",           limit: 255
    t.string   "Remark",            limit: 255
    t.string   "IP",                limit: 255
    t.string   "Agent",             limit: 255
    t.datetime "CreateTime"
    t.string   "CreateBy",          limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",          limit: 100
    t.integer  "Type",              limit: 4
  end

  create_table "returnpurchases", primary_key: "ID", force: :cascade do |t|
    t.string   "ReturnPurchaseCode",   limit: 255
    t.string   "ReturnPurchaseTitle",  limit: 255
    t.text     "ReturnPurchaseRemark", limit: 4294967295
    t.integer  "Status",               limit: 4,                                   null: false
    t.datetime "ReturnDate"
    t.text     "Log",                  limit: 4294967295
    t.string   "SupplierId",           limit: 36
    t.string   "SupplierName",         limit: 255
    t.string   "DepotId",              limit: 36
    t.string   "DepotName",            limit: 255
    t.string   "PurchaseID",           limit: 36
    t.datetime "CreateTime"
    t.string   "CreateBy",             limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",             limit: 100
    t.decimal  "TotalPrice",                              precision: 18, scale: 4
    t.decimal  "FinanceReturnPrice",                      precision: 18, scale: 2
    t.decimal  "HasDeduction",                            precision: 18, scale: 4
    t.integer  "ReturnGoodsType",      limit: 4
    t.string   "CompanyID",            limit: 36
    t.binary   "IsSaleSyProxy",        limit: 1
    t.binary   "IsYf",                 limit: 1
  end

  add_index "returnpurchases", ["DepotId"], name: "IX_DepotId", using: :btree
  add_index "returnpurchases", ["PurchaseID"], name: "IX_PurchaseID", using: :btree

  create_table "salecubelogs", primary_key: "ID", force: :cascade do |t|
    t.string   "LogStep",    limit: 255
    t.string   "LogMessage", limit: 255
    t.datetime "CreateTime"
    t.string   "CreateBy",   limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",   limit: 100
  end

  create_table "salesmanorderinfolists", id: false, force: :cascade do |t|
    t.datetime "OrderDate"
    t.string   "SaleID",                 limit: 36
    t.string   "SaleName",               limit: 255
    t.string   "CompanyID",              limit: 36
    t.string   "ParentId",               limit: 36
    t.string   "SaleManagerName",        limit: 255
    t.string   "ItCode",                 limit: 255
    t.integer  "OrderTotalCount",        limit: 4
    t.integer  "ReturnOrderTotalCount",  limit: 4
    t.decimal  "OrderProductTotalPrice",             precision: 18, scale: 4
    t.decimal  "GiveawayTotalPrice",                 precision: 18, scale: 4
    t.decimal  "CouponTotalPrice",                   precision: 18, scale: 4
    t.decimal  "PointTotalPrice",                    precision: 18, scale: 4
    t.decimal  "LogiTotalPrice",                     precision: 18, scale: 4
    t.decimal  "TotalMoney",                         precision: 18, scale: 4
    t.decimal  "TotalReceivedPrice",                 precision: 18, scale: 4
    t.decimal  "ReturnTotalPrice",                   precision: 18, scale: 4
    t.string   "ManagerCountyID",        limit: 36
  end

  create_table "salesmanorderinfolisttemp", id: false, force: :cascade do |t|
    t.datetime "OrderDate"
    t.string   "SaleID",                 limit: 36,                           default: "",  null: false
    t.string   "SaleName",               limit: 255
    t.string   "CompanyID",              limit: 36
    t.string   "ParentId",               limit: 36
    t.string   "SaleManagerName",        limit: 255
    t.string   "ItCode",                 limit: 255
    t.integer  "OrderTotalCount",        limit: 8,                            default: 0,   null: false
    t.integer  "ReturnOrderTotalCount",  limit: 8,                            default: 0,   null: false
    t.decimal  "OrderProductTotalPrice",             precision: 50, scale: 2, default: 0.0, null: false
    t.decimal  "GiveawayTotalPrice",                 precision: 18, scale: 2, default: 0.0, null: false
    t.decimal  "CouponTotalPrice",                   precision: 18, scale: 2, default: 0.0, null: false
    t.decimal  "PointTotalPrice",                    precision: 18, scale: 2, default: 0.0, null: false
    t.decimal  "LogiTotalPrice",                     precision: 18, scale: 2, default: 0.0, null: false
    t.decimal  "TotalMoney",                         precision: 18, scale: 2, default: 0.0, null: false
    t.decimal  "TotalReceivedPrice",                 precision: 18, scale: 2, default: 0.0, null: false
    t.decimal  "ReturnTotalPrice",                   precision: 50, scale: 2, default: 0.0, null: false
    t.string   "ManagerCountyID",        limit: 36
  end

  create_table "salesmen", primary_key: "ID", force: :cascade do |t|
    t.string   "SaleName",    limit: 255
    t.string   "SaleTel",     limit: 255
    t.string   "SaleAddress", limit: 255
    t.string   "SaleEmail",   limit: 255
    t.datetime "CreateTime"
    t.string   "CreateBy",    limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",    limit: 100
    t.string   "ParentId",    limit: 36
    t.integer  "IsManager",   limit: 4
    t.string   "ItCode",      limit: 255
    t.string   "InviteCode",  limit: 4
    t.string   "CompanyID",   limit: 36
    t.boolean  "OnTheJob",    limit: 1
    t.string   "CountyID",    limit: 36
  end

  add_index "salesmen", ["ParentId", "ID", "CompanyID"], name: "IDX_PA_ID_CO", using: :btree

  create_table "salesyproxies", primary_key: "ID", force: :cascade do |t|
    t.string   "SupplierID", limit: 36,                                        null: false
    t.string   "DepotID",    limit: 36,                           default: "", null: false
    t.string   "ProductID",  limit: 36,                           default: "", null: false
    t.integer  "Number",     limit: 4,                                         null: false
    t.decimal  "Price",                  precision: 18, scale: 4
    t.integer  "Type",       limit: 4
    t.string   "DataID",     limit: 36
    t.datetime "CreateTime"
    t.string   "CreateBy",   limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",   limit: 100
    t.string   "Remark",     limit: 255
  end

  add_index "salesyproxies", ["Type"], name: "IDX_TYPE", using: :btree

  create_table "salesyproxies1604221851", primary_key: "ID", force: :cascade do |t|
    t.string   "SupplierID", limit: 36,                                        null: false
    t.string   "DepotID",    limit: 36,                           default: "", null: false
    t.string   "ProductID",  limit: 36,                           default: "", null: false
    t.integer  "Number",     limit: 4,                                         null: false
    t.decimal  "Price",                  precision: 18, scale: 4
    t.integer  "Type",       limit: 4
    t.string   "DataID",     limit: 36
    t.datetime "CreateTime"
    t.string   "CreateBy",   limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",   limit: 100
    t.string   "Remark",     limit: 255
  end

  create_table "scf_bindbankcard", primary_key: "ID", force: :cascade do |t|
    t.string   "SupplierID",   limit: 36
    t.string   "IdNo",         limit: 255
    t.string   "UserName",     limit: 255
    t.string   "CardNumber",   limit: 255
    t.string   "MobilePhone",  limit: 255
    t.string   "Result",       limit: 255
    t.string   "RegisterTime", limit: 255
    t.string   "Reason",       limit: 255
    t.datetime "CreateTime"
    t.string   "CreateBy",     limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",     limit: 100
  end

  create_table "scf_email_validatesxxxxxxxxxxxxxxxxx", primary_key: "ID", force: :cascade do |t|
    t.string   "Email",      limit: 255
    t.string   "VCode",      limit: 255
    t.datetime "BeginTime"
    t.datetime "EndTime"
    t.integer  "Status",     limit: 4
    t.datetime "CreateTime"
    t.string   "CreateBy",   limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",   limit: 100
  end

  create_table "scf_order_details", primary_key: "ID", force: :cascade do |t|
    t.string   "OrderID",      limit: 36
    t.integer  "PeriodNumber", limit: 4
    t.datetime "DueDate"
    t.decimal  "DueCapital",               precision: 18, scale: 2
    t.decimal  "DueInterest",              precision: 18, scale: 2
    t.datetime "CreateTime"
    t.string   "CreateBy",     limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",     limit: 100
  end

  create_table "scf_order_logs", primary_key: "ID", force: :cascade do |t|
    t.string   "OrderID",     limit: 36
    t.string   "Description", limit: 255
    t.datetime "CreateTime"
    t.string   "CreateBy",    limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",    limit: 100
    t.string   "Amount",      limit: 255
    t.string   "Status",      limit: 255
  end

  create_table "scf_orders", primary_key: "ID", force: :cascade do |t|
    t.string   "SupplierID",    limit: 36
    t.string   "PurchaseID",    limit: 36
    t.string   "LoanId",        limit: 36
    t.decimal  "Amount",                    precision: 18, scale: 2
    t.decimal  "Rate",                      precision: 18, scale: 2
    t.integer  "LoanTerm",      limit: 4
    t.integer  "PaymentOption", limit: 4
    t.string   "ProductId",     limit: 255
    t.integer  "Status",        limit: 4
    t.string   "Reason",        limit: 255
    t.datetime "CreateTime"
    t.string   "CreateBy",      limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",      limit: 100
    t.datetime "LoanTime"
  end

  create_table "scf_supplier_rates", primary_key: "ID", force: :cascade do |t|
    t.string   "SupplierID",    limit: 36
    t.decimal  "Rate",                      precision: 18, scale: 2
    t.integer  "LoanTerm",      limit: 4
    t.integer  "PaymentOption", limit: 4
    t.boolean  "IsEnabled",     limit: 1
    t.datetime "CreateTime"
    t.string   "CreateBy",      limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",      limit: 100
  end

  create_table "scf_suppliers", primary_key: "ID", force: :cascade do |t|
    t.string   "Email",                 limit: 255
    t.string   "Password",              limit: 255
    t.string   "UserName",              limit: 255
    t.string   "UserPhone",             limit: 255
    t.string   "IDNo",                  limit: 255
    t.string   "CardNumber",            limit: 255
    t.decimal  "CreditLimit",                        precision: 18, scale: 2
    t.decimal  "AvailableBalance",                   precision: 18, scale: 2
    t.string   "UserIdResource",        limit: 255
    t.string   "RegisterName",          limit: 255
    t.string   "RegisterAdd",           limit: 1024
    t.string   "LegalRepName",          limit: 255
    t.string   "LegalRepId",            limit: 255
    t.string   "LegalRepMobile",        limit: 255
    t.string   "LegalRepAdd",           limit: 1024
    t.string   "ActualAdd",             limit: 1024
    t.string   "BussinesLicenceNum",    limit: 255
    t.string   "BussinesLicencePhoto",  limit: 255
    t.string   "TaxRegistrationPhoto",  limit: 255
    t.string   "OrganizationCodePhoto", limit: 255
    t.string   "Platform",              limit: 255
    t.string   "IdPhotoFront",          limit: 255
    t.string   "IdPhotoFrontGPS",       limit: 255
    t.string   "OutsidePhoto",          limit: 255
    t.string   "OutsidePhotoGPS",       limit: 255
    t.string   "InsidePhoto",           limit: 255
    t.string   "InsidePhotoGPS",        limit: 255
    t.string   "AlipayToken",           limit: 255
    t.string   "IndustryCode",          limit: 255
    t.string   "RiskRating",            limit: 255
    t.string   "MerchantsLevel",        limit: 255
    t.string   "BussinessType",         limit: 255
    t.boolean  "IsCompanyAccount",      limit: 1
    t.datetime "CreateTime"
    t.string   "CreateBy",              limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",              limit: 100
    t.integer  "Status",                limit: 4
    t.string   "Reason",                limit: 255
    t.string   "RememberToken",         limit: 255
    t.float    "SourceCreditLimt",      limit: 53,                            default: 0.0
  end

  create_table "searchconditions", primary_key: "ID", force: :cascade do |t|
    t.text     "Name",       limit: 4294967295
    t.string   "UserID",     limit: 36,         default: "", null: false
    t.text     "Condition",  limit: 4294967295
    t.text     "VMName",     limit: 4294967295
    t.datetime "CreateTime"
    t.string   "CreateBy",   limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",   limit: 100
  end

  add_index "searchconditions", ["UserID"], name: "IX_UserID", using: :btree

  create_table "sendordercountbydates", id: false, force: :cascade do |t|
    t.string  "OperationDate",  limit: 10
    t.integer "SendOrderCount", limit: 8,  default: 0, null: false
    t.string  "depotid",        limit: 36
    t.string  "CompanyID",      limit: 36
  end

  create_table "shelfproductrelations", primary_key: "ID", force: :cascade do |t|
    t.string   "DepotID",     limit: 36,         default: "", null: false
    t.string   "ShelvesID",   limit: 36
    t.string   "ProductID",   limit: 36,         default: "", null: false
    t.text     "ProductName", limit: 4294967295
    t.text     "ProductCode", limit: 4294967295
    t.datetime "CreateTime"
    t.string   "CreateBy",    limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",    limit: 100
  end

  add_index "shelfproductrelations", ["ProductID"], name: "IX_ProductID", using: :btree
  add_index "shelfproductrelations", ["ShelvesID"], name: "IX_ShelvesID", using: :btree

  create_table "shelfproducts", id: false, force: :cascade do |t|
    t.string   "ID",             limit: 36,                           null: false
    t.string   "DepotID",        limit: 36
    t.string   "DepotShelfID",   limit: 36
    t.string   "ProductID",      limit: 36
    t.datetime "ExpirationDate"
    t.integer  "InNumber",       limit: 4
    t.integer  "OutNumber",      limit: 4
    t.datetime "CreateTime"
    t.string   "CreateBy",       limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",       limit: 100
    t.integer  "Type",           limit: 4
    t.decimal  "CostPrice",                  precision: 18, scale: 4
    t.string   "DataID",         limit: 36
    t.string   "DetailID",       limit: 36
  end

  create_table "smautoresponses", primary_key: "ID", force: :cascade do |t|
    t.string   "Keywords",     limit: 255
    t.integer  "ResponseType", limit: 4
    t.string   "MediaID",      limit: 255
    t.string   "MediaName",    limit: 255
    t.text     "Description",  limit: 65535
    t.string   "CoverPic",     limit: 255
    t.integer  "Status",       limit: 4
    t.datetime "CreateTime"
    t.string   "CreateBy",     limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",     limit: 100
  end

  create_table "smbanks", primary_key: "ID", force: :cascade do |t|
    t.string   "Name",       limit: 255
    t.integer  "DataLevel",  limit: 4
    t.string   "ParentID",   limit: 36
    t.datetime "CreateTime"
    t.string   "CreateBy",   limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",   limit: 100
  end

  create_table "smcommissioncoefficientdetails", primary_key: "ID", force: :cascade do |t|
    t.string   "CommissionCoefficientID", limit: 36
    t.integer  "Level",                   limit: 4
    t.decimal  "BeginPrice",                          precision: 18, scale: 2
    t.decimal  "EndPrice",                            precision: 18, scale: 2
    t.decimal  "Coefficient",                         precision: 18, scale: 2
    t.datetime "CreateTime"
    t.string   "CreateBy",                limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",                limit: 100
    t.decimal  "CoefficientMoney",                    precision: 18, scale: 2
  end

  create_table "smcommissioncoefficientlogs", primary_key: "ID", force: :cascade do |t|
    t.string   "CommissionCoefficientID", limit: 36
    t.integer  "DataStatus",              limit: 4
    t.string   "Remark",                  limit: 255
    t.datetime "CreateTime"
    t.string   "CreateBy",                limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",                limit: 100
  end

  create_table "smcommissioncoefficients", primary_key: "ID", force: :cascade do |t|
    t.integer  "Year",       limit: 4
    t.integer  "Month",      limit: 4
    t.integer  "Week",       limit: 4
    t.datetime "BeginTime"
    t.datetime "EndTime"
    t.integer  "Status",     limit: 4
    t.datetime "CreateTime"
    t.string   "CreateBy",   limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",   limit: 100
    t.string   "CompanyID",  limit: 36
    t.integer  "WeekOfYear", limit: 4
  end

  create_table "smmenus", primary_key: "ID", force: :cascade do |t|
    t.string   "Name",         limit: 255
    t.integer  "Level",        limit: 4
    t.string   "Parent",       limit: 36
    t.string   "Title",        limit: 255
    t.integer  "ResponseType", limit: 4
    t.string   "MediaID",      limit: 255
    t.string   "MediaName",    limit: 255
    t.text     "Description",  limit: 65535
    t.string   "CoverPic",     limit: 255
    t.string   "NewsLink",     limit: 255
    t.integer  "Status",       limit: 4
    t.datetime "CreateTime"
    t.string   "CreateBy",     limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",     limit: 100
    t.integer  "Sort",         limit: 4
  end

  create_table "smproductlogs", primary_key: "ID", force: :cascade do |t|
    t.string   "ProductID",               limit: 36
    t.decimal  "SMCommissionCoefficient",             precision: 18, scale: 2
    t.integer  "RecommendSort",           limit: 4
    t.string   "Remark",                  limit: 255
    t.datetime "CreateTime"
    t.string   "CreateBy",                limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",                limit: 100
  end

  create_table "smuserblacklists", primary_key: "ID", force: :cascade do |t|
    t.string   "SMUserID",   limit: 36
    t.string   "Name",       limit: 255
    t.string   "Mobile",     limit: 255
    t.string   "IDcardNo",   limit: 255
    t.string   "BankCardNo", limit: 255
    t.datetime "CreateTime"
    t.string   "CreateBy",   limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",   limit: 100
  end

  create_table "smuserlogs", primary_key: "ID", force: :cascade do |t|
    t.string   "SMUserID",     limit: 36
    t.integer  "SMUserStatus", limit: 4
    t.string   "Remark",       limit: 255
    t.datetime "CreateTime"
    t.string   "CreateBy",     limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",     limit: 100
    t.integer  "LogType",      limit: 4
    t.binary   "IsSucceed",    limit: 1
    t.string   "RealName",     limit: 255
    t.string   "IDCard",       limit: 255
    t.string   "BankCard",     limit: 255
    t.string   "Mobile",       limit: 255
  end

  create_table "smuserrelations", primary_key: "ID", force: :cascade do |t|
    t.string   "SMUserID",       limit: 36
    t.string   "RelationUserID", limit: 36
    t.datetime "CreateTime"
    t.string   "CreateBy",       limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",       limit: 100
  end

  create_table "smusers", primary_key: "ID", force: :cascade do |t|
    t.string   "Mobile",         limit: 255
    t.string   "Password",       limit: 255
    t.string   "ProvinceID",     limit: 36
    t.string   "CityID",         limit: 36
    t.string   "CountyID",       limit: 36
    t.string   "Name",           limit: 255
    t.string   "IDcardNo",       limit: 255
    t.string   "IDcardPic",      limit: 255
    t.string   "BankCardNo",     limit: 255
    t.string   "BandCardPic",    limit: 255
    t.string   "InvitationCode", limit: 255
    t.integer  "Status",         limit: 8
    t.datetime "AuditedTime"
    t.string   "CompanyID",      limit: 36
    t.datetime "CreateTime"
    t.string   "CreateBy",       limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",       limit: 100
    t.string   "RememberToken",  limit: 255
    t.string   "OpenID",         limit: 255
    t.integer  "UserType",       limit: 4
    t.boolean  "IsAgreement",    limit: 1
    t.boolean  "IsDisabled",     limit: 1,   default: false
    t.integer  "SceneID",        limit: 8
    t.string   "BankBranch",     limit: 255
    t.string   "BankAccount",    limit: 255
    t.string   "BankProvince",   limit: 255
    t.string   "BankCity",       limit: 255
  end

  add_index "smusers", ["InvitationCode"], name: "index_InvitationCode", using: :btree
  add_index "smusers", ["Mobile"], name: "index_Mobile", using: :btree
  add_index "smusers", ["Name"], name: "index_Name", using: :btree

  create_table "smuserweekcommissions", primary_key: "ID", force: :cascade do |t|
    t.string   "SMUserID",            limit: 36
    t.integer  "Year",                limit: 4
    t.integer  "Month",               limit: 4
    t.integer  "Week",                limit: 4
    t.integer  "WeekOfYear",          limit: 4
    t.decimal  "OrderTotalPrice",                 precision: 18, scale: 4
    t.decimal  "CoefficientMoney",                precision: 18, scale: 4
    t.decimal  "Coefficient",                     precision: 18, scale: 4
    t.decimal  "ProductCommission",               precision: 18, scale: 4
    t.decimal  "TotalCommission",                 precision: 18, scale: 4
    t.decimal  "ReturnOfGoodsRate",               precision: 18, scale: 4
    t.decimal  "ReturnOfGoodsAmerce",             precision: 18, scale: 4
    t.decimal  "TotalReward",                     precision: 18, scale: 4
    t.datetime "CreateTime"
    t.string   "CreateBy",            limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",            limit: 100
    t.decimal  "ServicePoint",                    precision: 18, scale: 2
    t.decimal  "AmountPayable",                   precision: 18, scale: 2
    t.integer  "ConsumerCount",       limit: 4
    t.string   "CompanyID",           limit: 36
    t.decimal  "TotalReceivedPrice",              precision: 18, scale: 4
  end

  create_table "split_order_detail", primary_key: "ID", force: :cascade do |t|
    t.string   "OrderId",           limit: 36,               null: false
    t.string   "PID",               limit: 36,               null: false
    t.string   "OperationItCode",   limit: 255,              null: false
    t.string   "OperationUserName", limit: 255,              null: false
    t.datetime "OperationTime",                              null: false
    t.string   "DepotID",           limit: 36,               null: false
    t.datetime "CreateTime",                                 null: false
    t.string   "CreateBy",          limit: 100,              null: false
    t.datetime "UpdateTime",                                 null: false
    t.string   "UpdateBy",          limit: 100,              null: false
    t.string   "CompanyID",         limit: 36,  default: ""
  end

  add_index "split_order_detail", ["PID"], name: "idx_PID", using: :btree

  create_table "statisticsskubyeverydays", primary_key: "ID", force: :cascade do |t|
    t.datetime "QueryDate"
    t.string   "CompanyID",           limit: 36
    t.string   "DepotID",             limit: 36
    t.string   "ProductID",           limit: 36
    t.integer  "OrderCount",          limit: 4
    t.decimal  "OrderPrice",                      precision: 18, scale: 4
    t.integer  "OutProductCount",     limit: 4
    t.decimal  "AvgOrderPrice",                   precision: 18, scale: 4
    t.decimal  "BeforePurchasePrice",             precision: 18, scale: 4
    t.decimal  "GrossProfitRatio",                precision: 18, scale: 4
    t.datetime "CreateTime"
    t.string   "CreateBy",            limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",            limit: 100
    t.string   "CountyID",            limit: 36
  end

  create_table "storeinformation_logs", primary_key: "ID", force: :cascade do |t|
    t.string   "StoreinfomationID", limit: 36
    t.integer  "Status",            limit: 4
    t.text     "Remark",            limit: 4294967295
    t.string   "IP",                limit: 255
    t.string   "Agent",             limit: 255
    t.datetime "CreateTime"
    t.string   "CreateBy",          limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",          limit: 100
  end

  create_table "storeinformations", primary_key: "ID", force: :cascade do |t|
    t.string   "ReceiveName",            limit: 255
    t.string   "Tel",                    limit: 255
    t.string   "FaceName",               limit: 255
    t.string   "Address",                limit: 255
    t.string   "FacePhotoCoverNiuID",    limit: 255
    t.string   "LicencePhotoCoverNiuID", limit: 255
    t.string   "Province",               limit: 255
    t.string   "City",                   limit: 255
    t.string   "Area",                   limit: 255
    t.integer  "Status",                 limit: 4,   default: 0
    t.datetime "CreateTime"
    t.string   "CreateBy",               limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",               limit: 100
    t.string   "UserAddressID",          limit: 36
    t.string   "RejectReason",           limit: 100
    t.integer  "StoreType",              limit: 4
    t.integer  "Nearby",                 limit: 4
    t.integer  "StoreArea",              limit: 4
    t.boolean  "IsChain",                limit: 1
    t.string   "RegisterPhone",          limit: 255
  end

  create_table "streets", primary_key: "ID", force: :cascade do |t|
    t.string   "StreetName", limit: 255, null: false
    t.string   "StreetCode", limit: 255, null: false
    t.string   "CountyID",   limit: 36
    t.datetime "CreateTime"
    t.string   "CreateBy",   limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",   limit: 100
  end

  add_index "streets", ["CountyID"], name: "IX_CountyID", using: :btree

  create_table "supplieradvances", primary_key: "ID", force: :cascade do |t|
    t.string   "CompanyID",      limit: 36
    t.string   "SupplierID",     limit: 36
    t.decimal  "YFMoney",                           precision: 18, scale: 2
    t.integer  "status",         limit: 4
    t.datetime "CreateTime"
    t.string   "CreateBy",       limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",       limit: 100
    t.text     "ApprovalBy",     limit: 4294967295
    t.decimal  "AdvanceBalance",                    precision: 18, scale: 2
  end

  add_index "supplieradvances", ["CompanyID"], name: "IX_CompanyID", using: :btree
  add_index "supplieradvances", ["SupplierID"], name: "IX_SupplierID", using: :btree

  create_table "suppliercomrelations", primary_key: "ID", force: :cascade do |t|
    t.string   "SupplierID", limit: 36
    t.string   "CompanyID",  limit: 36
    t.datetime "CreateTime"
    t.string   "CreateBy",   limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",   limit: 100
  end

  add_index "suppliercomrelations", ["CompanyID"], name: "IX_CompanyID", using: :btree
  add_index "suppliercomrelations", ["SupplierID"], name: "IX_SupplierID", using: :btree

  create_table "supplierlogs", primary_key: "ID", force: :cascade do |t|
    t.string   "SupplierID", limit: 36
    t.integer  "Type",       limit: 4
    t.decimal  "CostItem",               precision: 18, scale: 2
    t.datetime "CreateTime"
    t.string   "CreateBy",   limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",   limit: 100
    t.string   "PurchaseID", limit: 36
  end

  create_table "supplierproductbrandrelations", primary_key: "ID", force: :cascade do |t|
    t.string   "SupplierID",     limit: 36
    t.string   "ProductBrandID", limit: 36
    t.datetime "CreateTime"
    t.string   "CreateBy",       limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",       limit: 100
  end

  add_index "supplierproductbrandrelations", ["SupplierID"], name: "IX_SupplierID", using: :btree

  create_table "suppliers", primary_key: "ID", force: :cascade do |t|
    t.string   "SupplierName",       limit: 255
    t.string   "Address",            limit: 255
    t.string   "AccountName",        limit: 255
    t.string   "AccountBank",        limit: 255
    t.string   "AccountNumber",      limit: 255
    t.string   "LinkMan",            limit: 255
    t.string   "LinkPhone",          limit: 255
    t.string   "LinkEmail",          limit: 255
    t.text     "Remark",             limit: 4294967295
    t.datetime "CreateTime"
    t.string   "CreateBy",           limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",           limit: 100
    t.decimal  "DeductionPrice",                        precision: 18, scale: 4, default: 0.0
    t.string   "QQ",                 limit: 255
    t.string   "WeChart",            limit: 255
    t.string   "AccountPeriod",      limit: 255
    t.decimal  "AdvanceBalance",                        precision: 18, scale: 4
    t.string   "Category",           limit: 255
    t.string   "PhotoID1",           limit: 36
    t.string   "PhotoID2",           limit: 36
    t.string   "PhotoID3",           limit: 36
    t.integer  "Status",             limit: 4
    t.integer  "SetDay",             limit: 4
    t.integer  "InvoiceType",        limit: 1
    t.string   "BussinesLicenceNum", limit: 255
    t.string   "SCFSupplierID",      limit: 36
  end

  create_table "suppliersalesyproxies", id: false, force: :cascade do |t|
    t.string   "id",                limit: 36
    t.string   "supplierid",        limit: 36,                             null: false
    t.string   "depotid",           limit: 36,                default: "", null: false
    t.string   "productid",         limit: 36,                default: "", null: false
    t.decimal  "number",                       precision: 32
    t.decimal  "purchasein",                   precision: 32
    t.decimal  "returnpurchaseout",            precision: 32
    t.decimal  "orderout",                     precision: 32
    t.decimal  "returnorderin",                precision: 32
    t.decimal  "mtchange",                     precision: 32
    t.datetime "CreateTime"
    t.binary   "CreateBy",          limit: 0
    t.binary   "UpdateTime",        limit: 0
    t.binary   "UpdateBy",          limit: 0
    t.integer  "Type",              limit: 4
    t.string   "DataID",            limit: 36
  end

  create_table "syslogs", primary_key: "ID", force: :cascade do |t|
    t.string   "Type",            limit: 255
    t.text     "LogMessage",      limit: 4294967295
    t.datetime "CreatedDate"
    t.integer  "CreatedUserId",   limit: 4
    t.string   "CreatedUserName", limit: 255
    t.datetime "CreateTime"
    t.string   "CreateBy",        limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",        limit: 100
  end

  create_table "taggroups", primary_key: "ID", force: :cascade do |t|
    t.string   "Name",           limit: 255
    t.string   "ProductGroupID", limit: 36
    t.datetime "CreateTime"
    t.string   "CreateBy",       limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",       limit: 100
  end

  add_index "taggroups", ["ProductGroupID"], name: "IX_ProductGroupID", using: :btree

  create_table "tags", primary_key: "ID", force: :cascade do |t|
    t.string   "Name",       limit: 255
    t.string   "TagGroupID", limit: 36
    t.datetime "CreateTime"
    t.string   "CreateBy",   limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",   limit: 100
  end

  add_index "tags", ["TagGroupID"], name: "IX_TagGroupID", using: :btree

  create_table "temp_avgprice", force: :cascade do |t|
    t.string  "pid",      limit: 36,                          null: false
    t.decimal "avgprice",            precision: 18, scale: 4
  end

  create_table "temp_depotproductstocks_160626", id: false, force: :cascade do |t|
    t.string  "DepotID",   limit: 36, default: "", null: false
    t.string  "ProductID", limit: 36, default: "", null: false
    t.integer "RealStock", limit: 8,  default: 0,  null: false
  end

  create_table "temp_depotproductstocks_160726", id: false, force: :cascade do |t|
    t.string  "DepotID",   limit: 36, default: "", null: false
    t.string  "ProductID", limit: 36, default: "", null: false
    t.integer "RealStock", limit: 8,  default: 0,  null: false
  end

  create_table "temp_depotstock", force: :cascade do |t|
    t.string  "depotid",             limit: 36,                           null: false
    t.string  "dname",               limit: 36
    t.string  "pid",                 limit: 36,                           null: false
    t.string  "code",                limit: 36,                           null: false
    t.string  "pname",               limit: 255
    t.decimal "beforepurchaseprice",             precision: 18, scale: 4
  end

  create_table "temp_groupprice", force: :cascade do |t|
    t.string  "pid",   limit: 36,                          null: false
    t.decimal "price",            precision: 18, scale: 4
  end

  create_table "temp_purchaseprice", force: :cascade do |t|
    t.string  "depotid",  limit: 36,                          null: false
    t.string  "dname",    limit: 36
    t.string  "pid",      limit: 36,                          null: false
    t.decimal "avgprice",            precision: 18, scale: 4
  end

  create_table "temp_purchaseprice_160626", id: false, force: :cascade do |t|
    t.string  "CompanyID",     limit: 36
    t.string  "DepotID",       limit: 36
    t.string  "ProductID",     limit: 36
    t.decimal "PurchasePrice",            precision: 54, scale: 8, default: 0.0, null: false
  end

  create_table "temp_purchases", id: false, force: :cascade do |t|
    t.string   "ID",           limit: 36,                           default: "", null: false
    t.string   "PurchaseCode", limit: 255
    t.integer  "Status",       limit: 4
    t.integer  "Shipstatus",   limit: 4
    t.datetime "UpdateTime"
    t.string   "SupplierName", limit: 255
    t.string   "DepotID",      limit: 36
    t.string   "ProductID",    limit: 36
    t.decimal  "avgprice",                 precision: 18, scale: 4
  end

  create_table "test", primary_key: "Id", force: :cascade do |t|
    t.string "Index",  limit: 255
    t.string "IntVal", limit: 255
  end

  add_index "test", ["Index"], name: "Index", unique: true, using: :btree

  create_table "thetable", primary_key: "pid", force: :cascade do |t|
    t.datetime "timestamp"
    t.integer  "cost",      limit: 4, null: false
    t.integer  "rid",       limit: 4, null: false
  end

  create_table "thirdcallbackrecord", primary_key: "Id", force: :cascade do |t|
    t.datetime "CreateTime",                null: false
    t.integer  "PayType",     limit: 1,     null: false
    t.text     "CallContent", limit: 65535, null: false
    t.integer  "CallType",    limit: 1,     null: false
    t.string   "RequestId",   limit: 128,   null: false
    t.string   "OrderCode",   limit: 64,    null: false
    t.string   "RandomCode",  limit: 64,    null: false
  end

  create_table "thirdreqparam", primary_key: "Id", force: :cascade do |t|
    t.string "RequestId", limit: 128,   null: false
    t.text   "Url",       limit: 65535, null: false
    t.text   "Pms",       limit: 65535, null: false
    t.string "Method",    limit: 32,    null: false
    t.text   "Response",  limit: 65535
  end

  create_table "thirdreqrecord", primary_key: "Id", force: :cascade do |t|
    t.string   "OrderCode",  limit: 64,  null: false
    t.string   "RandomCode", limit: 64,  null: false
    t.string   "RequestId",  limit: 128, null: false
    t.integer  "ThirdType",  limit: 1,   null: false
    t.datetime "CreateTime",             null: false
    t.integer  "Status",     limit: 1,   null: false
  end

  create_table "updateintegrallogs", primary_key: "ID", force: :cascade do |t|
    t.string   "AuthToken",    limit: 255
    t.integer  "DeltaPoint",   limit: 4
    t.integer  "Type",         limit: 4
    t.string   "Remark",       limit: 255
    t.string   "UpdateRemark", limit: 512
    t.string   "OrderId",      limit: 36
    t.boolean  "IsResolved",   limit: 1
    t.datetime "CreateTime"
    t.string   "CreateBy",     limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",     limit: 100
  end

  create_table "user_levels", primary_key: "ID", force: :cascade do |t|
    t.string   "UserID",          limit: 36
    t.integer  "Year",            limit: 4
    t.integer  "Month",           limit: 4
    t.integer  "OrderCount",      limit: 4
    t.decimal  "OrderPrice",                  precision: 18, scale: 2
    t.integer  "SKU",             limit: 4
    t.decimal  "UserGrowthValue",             precision: 18, scale: 2
    t.integer  "UserLevel",       limit: 4
    t.datetime "CreateTime"
    t.string   "CreateBy",        limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",        limit: 100
  end

  create_table "user_point_batch_logs", primary_key: "ID", force: :cascade do |t|
    t.string   "UserPointBatchID", limit: 36
    t.integer  "Status",           limit: 4
    t.text     "Remark",           limit: 4294967295
    t.string   "IP",               limit: 255
    t.string   "Agent",            limit: 255
    t.datetime "CreateTime"
    t.string   "CreateBy",         limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",         limit: 100
  end

  create_table "user_point_batches", primary_key: "ID", force: :cascade do |t|
    t.string   "UserID",       limit: 36
    t.integer  "Point",        limit: 4
    t.string   "Cause",        limit: 255
    t.integer  "Status",       limit: 4
    t.datetime "CreateTime"
    t.string   "CreateBy",     limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",     limit: 100
    t.integer  "CurrentPoint", limit: 4
    t.datetime "SubmitTime"
  end

  create_table "useraddresses", primary_key: "ID", force: :cascade do |t|
    t.string   "UserID",          limit: 36,                           default: "",    null: false
    t.string   "Province",        limit: 255
    t.string   "City",            limit: 255
    t.string   "County",          limit: 255
    t.string   "Detailedaddress", limit: 255
    t.string   "ZipCode",         limit: 255
    t.string   "ShipName",        limit: 255
    t.string   "Telephone",       limit: 255
    t.string   "Mobile",          limit: 255
    t.boolean  "IsDefault",       limit: 1
    t.datetime "CreateTime"
    t.string   "CreateBy",        limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",        limit: 100
    t.string   "CountyID",        limit: 36
    t.string   "CompanyID",       limit: 36
    t.string   "DepotID",         limit: 255
    t.string   "FaceName",        limit: 255
    t.boolean  "IsDeleted",       limit: 1,                            default: false
    t.string   "Supplements",     limit: 255
    t.decimal  "Longitude",                   precision: 11, scale: 8
    t.decimal  "Latitude",                    precision: 11, scale: 8
  end

  add_index "useraddresses", ["UserID"], name: "IX_UserID", using: :btree

  create_table "useraddressinfoes", primary_key: "ID", force: :cascade do |t|
    t.string   "UserAddress",       limit: 255
    t.string   "StatisticsMonth",   limit: 10
    t.integer  "OrderCount",        limit: 4
    t.integer  "SKUCount",          limit: 4
    t.decimal  "OrderPrice",                     precision: 18, scale: 2
    t.decimal  "ReceivedPrice",                  precision: 18, scale: 2
    t.datetime "LastOrderTime"
    t.datetime "CreateTime"
    t.string   "CreateBy",          limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",          limit: 100
    t.string   "UserType",          limit: 255
    t.string   "Measure",           limit: 255
    t.string   "ProvinceID",        limit: 36
    t.string   "CityID",            limit: 36
    t.string   "CountyID",          limit: 36
    t.string   "SalesmanID",        limit: 36
    t.string   "AddressPhoneList",  limit: 2000
    t.binary   "IsGoldUser",        limit: 1
    t.binary   "IsWholeSale",       limit: 1,                             default: "b'0'"
    t.string   "UserPhone",         limit: 255
    t.integer  "TotalCouponNumber", limit: 4
  end

  create_table "usercoupons", primary_key: "ID", force: :cascade do |t|
    t.string   "UsersID",         limit: 36
    t.datetime "EndDate"
    t.decimal  "Price",                       precision: 18, scale: 2
    t.integer  "Status",          limit: 1,                                           null: false
    t.integer  "Source",          limit: 1,                                           null: false
    t.datetime "CreateTime"
    t.string   "CreateBy",        limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",        limit: 100
    t.string   "Cause",           limit: 255
    t.datetime "StartDate"
    t.integer  "UseMoney",        limit: 4,                            default: 0
    t.string   "CouponAppliesID", limit: 36
    t.string   "CouponCode",      limit: 30
    t.string   "CouponApply_ID",  limit: 36
    t.string   "Users_ID",        limit: 36
    t.integer  "Type",            limit: 4
    t.string   "ProductID",       limit: 36
    t.string   "CouponID",        limit: 255
    t.boolean  "IsRead",          limit: 1,                            default: true
    t.decimal  "CouponDiscount",              precision: 8,  scale: 2
    t.integer  "ProvideCount",    limit: 4,                            default: 1
    t.integer  "CurrentCount",    limit: 4,                            default: 1
  end

  add_index "usercoupons", ["CouponCode"], name: "Unique_CouponCode", unique: true, using: :btree
  add_index "usercoupons", ["UsersID"], name: "IX_UsersID", using: :btree

  create_table "userlogs", primary_key: "ID", force: :cascade do |t|
    t.string   "UserID",     limit: 36,         null: false
    t.text     "Remark",     limit: 4294967295
    t.datetime "CreateTime"
    t.string   "CreateBy",   limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",   limit: 100
    t.string   "IP",         limit: 255
    t.string   "Agent",      limit: 255
  end

  create_table "users", primary_key: "ID", force: :cascade do |t|
    t.string   "Name",               limit: 255
    t.string   "Phone",              limit: 255
    t.string   "Mail",               limit: 255
    t.integer  "Age",                limit: 1
    t.boolean  "Sex",                limit: 1
    t.string   "Province",           limit: 255
    t.string   "City",               limit: 255
    t.string   "Area",               limit: 255
    t.string   "Address",            limit: 255
    t.string   "Password",           limit: 255
    t.integer  "BirthMonth",         limit: 1
    t.integer  "BirthDay",           limit: 1
    t.integer  "BirthYear",          limit: 2
    t.integer  "Type",               limit: 4,                            default: 1,    null: false
    t.integer  "State",              limit: 4,                                           null: false
    t.integer  "Integral",           limit: 4,                            default: 0
    t.string   "PhotoID",            limit: 36
    t.datetime "CreateTime"
    t.string   "CreateBy",           limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",           limit: 100
    t.boolean  "IsImportUser",       limit: 1
    t.string   "SalesmanID",         limit: 36
    t.string   "RememberToken",      limit: 255
    t.boolean  "IsLimitBuy",         limit: 1,                            default: true
    t.string   "UserCoupon_ID",      limit: 36
    t.string   "SalesmanInviteCode", limit: 4
    t.string   "CouponApply_ID",     limit: 36
    t.string   "CompanyID",          limit: 36
    t.string   "TagName",            limit: 255
    t.string   "UserTagsID",         limit: 255
    t.string   "FistSalesman",       limit: 36
    t.string   "FirstSMUser",        limit: 36
    t.datetime "FirstOrderTime"
    t.boolean  "IsChain",            limit: 1
    t.decimal  "CashVolume",                     precision: 11, scale: 2
  end

  add_index "users", ["Phone"], name: "IX_Phone", using: :btree
  add_index "users", ["PhotoID"], name: "IX_PhotoID", using: :btree
  add_index "users", ["RememberToken"], name: "IX_RememberToken", using: :btree
  add_index "users", ["SalesmanID"], name: "IX_SalesmanID", using: :btree

  create_table "users_copy", primary_key: "ID", force: :cascade do |t|
    t.string   "Name",               limit: 255
    t.string   "Phone",              limit: 255
    t.string   "Mail",               limit: 255
    t.integer  "Age",                limit: 1
    t.boolean  "Sex",                limit: 1
    t.string   "Province",           limit: 255
    t.string   "City",               limit: 255
    t.string   "Area",               limit: 255
    t.string   "Address",            limit: 255
    t.string   "Password",           limit: 255
    t.integer  "BirthMonth",         limit: 1
    t.integer  "BirthDay",           limit: 1
    t.integer  "BirthYear",          limit: 2
    t.integer  "Type",               limit: 4,                  null: false
    t.integer  "State",              limit: 4,                  null: false
    t.integer  "Integral",           limit: 4,   default: 0
    t.string   "PhotoID",            limit: 36
    t.datetime "CreateTime"
    t.string   "CreateBy",           limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",           limit: 100
    t.boolean  "IsImportUser",       limit: 1
    t.string   "SalesmanID",         limit: 36
    t.string   "RememberToken",      limit: 255
    t.boolean  "IsLimitBuy",         limit: 1,   default: true
    t.string   "UserCoupon_ID",      limit: 36
    t.string   "SalesmanInviteCode", limit: 4
    t.string   "CouponApply_ID",     limit: 36
    t.string   "CompanyID",          limit: 36
    t.string   "TagName",            limit: 255
    t.string   "UserTagsID",         limit: 255
  end

  add_index "users_copy", ["Phone"], name: "IX_Phone", using: :btree
  add_index "users_copy", ["PhotoID"], name: "IX_PhotoID", using: :btree
  add_index "users_copy", ["RememberToken"], name: "IX_RememberToken", using: :btree
  add_index "users_copy", ["SalesmanID"], name: "IX_SalesmanID", using: :btree

  create_table "usertags", primary_key: "ID", force: :cascade do |t|
    t.text     "TagsCode",   limit: 4294967295
    t.text     "TagsName",   limit: 4294967295
    t.integer  "OrderBy",    limit: 4
    t.datetime "CreateTime"
    t.string   "CreateBy",   limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",   limit: 100
    t.integer  "GroupID",    limit: 4
  end

  create_table "view_company_product_moveavg_purchaseprice", id: false, force: :cascade do |t|
    t.string  "ProductID",            limit: 36,                          default: "", null: false
    t.decimal "MoveAvgPurchasePrice",            precision: 54, scale: 4
  end

  create_table "view_currentmonth_totaldamage", id: false, force: :cascade do |t|
    t.string  "DepotID",           limit: 36,                          default: ""
    t.string  "ProductID",         limit: 36,                          default: ""
    t.decimal "TotalDamageNumber",            precision: 32
    t.decimal "TotalDamagePrice",             precision: 50, scale: 4
  end

  create_table "view_currentmonth_totalpurchase", id: false, force: :cascade do |t|
    t.string  "DepotID",             limit: 36
    t.string  "ProductID",           limit: 36
    t.decimal "TotalReceivedNumber",            precision: 32
    t.decimal "TotalPurchasePrice",             precision: 50, scale: 4
  end

  create_table "view_currentmonth_totalshift", id: false, force: :cascade do |t|
    t.string  "DepotIn",             limit: 36
    t.string  "ProductID",           limit: 36
    t.decimal "TotalReceivedNumber",            precision: 32
    t.decimal "TotalReceivedPrice",             precision: 50, scale: 4
  end

  create_table "view_order_products", id: false, force: :cascade do |t|
    t.string  "ProductID",        limit: 36
    t.string  "OrderID",          limit: 36
    t.decimal "Price",                       precision: 18, scale: 2
    t.decimal "DiscountPrice",               precision: 18, scale: 2
    t.integer "Quantity",         limit: 4,                           default: 0, null: false
    t.integer "RetrunNumber",     limit: 4
    t.integer "OOSNumber",        limit: 4
    t.decimal "MarketingExpense",            precision: 18, scale: 4
    t.decimal "MarketingIncome",             precision: 18, scale: 4
    t.decimal "ReceviedExpense",             precision: 18, scale: 4
    t.decimal "PriceProportion",             precision: 18, scale: 2
    t.decimal "ServicePoint",                precision: 18, scale: 2
    t.decimal "AvgPurchasePrice",            precision: 18, scale: 4
  end

  create_table "view_product_avg_purchaseprice", id: false, force: :cascade do |t|
    t.integer "Year",             limit: 4,                           null: false
    t.integer "Month",            limit: 4,                           null: false
    t.string  "CompanyID",        limit: 36,                          null: false
    t.string  "DepotID",          limit: 36,                          null: false
    t.string  "ProductID",        limit: 36,                          null: false
    t.decimal "AvgPurchasePrice",            precision: 44, scale: 8
  end

  create_table "view_product_moveavg_purchaseprice", id: false, force: :cascade do |t|
    t.string  "DepotID",              limit: 36,                           default: "",  null: false
    t.string  "ProductID",            limit: 36,                           default: "",  null: false
    t.integer "Stock",                limit: 4,                                          null: false
    t.integer "RealStock",            limit: 4
    t.decimal "MoveAvgPurchasePrice",            precision: 65, scale: 12, default: 0.0, null: false
  end

  create_table "view_product_purchaseprice_maxmonth", id: false, force: :cascade do |t|
    t.string "CompanyID", limit: 36, null: false
    t.string "DepotID",   limit: 36, null: false
    t.string "ProductID", limit: 36, null: false
    t.string "YearMonth", limit: 22
  end

  create_table "view_product_stock", id: false, force: :cascade do |t|
    t.integer  "Year",         limit: 4,               null: false
    t.integer  "Month",        limit: 4,               null: false
    t.string   "DepotID",      limit: 36, default: "", null: false
    t.string   "ProductID",    limit: 36, default: "", null: false
    t.integer  "RealStock",    limit: 8,  default: 0,  null: false
    t.datetime "CreateTime",                           null: false
    t.string   "MaxYearMonth", limit: 22
  end

  create_table "view_product_stock_maxmonth", id: false, force: :cascade do |t|
    t.string "MaxYearMonth", limit: 22
  end

  create_table "wfdefinations", primary_key: "ID", force: :cascade do |t|
    t.text     "Domain",          limit: 4294967295
    t.text     "Name",            limit: 4294967295
    t.text     "FormType",        limit: 4294967295
    t.text     "FormLayout",      limit: 4294967295
    t.text     "ListFields",      limit: 4294967295
    t.integer  "ShowComment",     limit: 4,          null: false
    t.integer  "ShowFlow",        limit: 4,          null: false
    t.boolean  "IsSubDefination", limit: 1,          null: false
    t.text     "WFDiagram",       limit: 4294967295
    t.datetime "CreateTime"
    t.string   "CreateBy",        limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",        limit: 100
  end

  create_table "wfdeflinks", primary_key: "ID", force: :cascade do |t|
    t.string "WFDefinationID", limit: 36,         default: "", null: false
    t.text   "ActionName",     limit: 4294967295
    t.text   "FlowCondition",  limit: 4294967295
    t.string "StartNodeID",    limit: 36
    t.string "EndNodeID",      limit: 36
  end

  add_index "wfdeflinks", ["EndNodeID"], name: "IX_EndNodeID", using: :btree
  add_index "wfdeflinks", ["StartNodeID"], name: "IX_StartNodeID", using: :btree

  create_table "wfdefnodes", primary_key: "ID", force: :cascade do |t|
    t.text    "Name",            limit: 4294967295
    t.text    "ActionNames",     limit: 4294967295
    t.text    "FormLayout",      limit: 4294967295
    t.integer "ShowComment",     limit: 4
    t.integer "ShowFlow",        limit: 4,                       null: false
    t.text    "NodePermissions", limit: 4294967295
    t.text    "UserCondition",   limit: 4294967295
    t.integer "ApproveType",     limit: 4,                       null: false
    t.string  "SubDefinationID", limit: 36
    t.string  "WFDefinationID",  limit: 36,         default: "", null: false
  end

  add_index "wfdefnodes", ["WFDefinationID"], name: "IX_WFDefinationID", using: :btree

  create_table "wfdimuserrels", primary_key: "ID", force: :cascade do |t|
    t.text "Domain",    limit: 4294967295
    t.text "DimName",   limit: 4294967295
    t.text "ModelName", limit: 4294967295
    t.text "ModelType", limit: 4294967295
    t.text "Url",       limit: 4294967295
  end

  create_table "wx_qrcode", primary_key: "PID", force: :cascade do |t|
    t.string   "OrderCode",  limit: 255
    t.datetime "CreateTime"
    t.string   "ID",         limit: 36
  end

  add_index "wx_qrcode", ["OrderCode"], name: "idx_ordercode", unique: true, using: :btree

  create_table "wxautoresponses", primary_key: "ID", force: :cascade do |t|
    t.string   "Keywords",     limit: 255
    t.integer  "ResponseType", limit: 4
    t.string   "MediaID",      limit: 255
    t.string   "MediaName",    limit: 255
    t.text     "Description",  limit: 65535
    t.string   "CoverPic",     limit: 255
    t.integer  "Status",       limit: 4
    t.datetime "CreateTime"
    t.string   "CreateBy",     limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",     limit: 100
  end

  create_table "wxmenus", primary_key: "ID", force: :cascade do |t|
    t.string   "Name",         limit: 255
    t.integer  "Level",        limit: 4
    t.string   "Parent",       limit: 36
    t.string   "Title",        limit: 255
    t.integer  "ResponseType", limit: 4
    t.string   "MediaID",      limit: 255
    t.string   "MediaName",    limit: 255
    t.text     "Description",  limit: 65535
    t.string   "CoverPic",     limit: 255
    t.string   "NewsLink",     limit: 255
    t.integer  "Status",       limit: 4
    t.datetime "CreateTime"
    t.string   "CreateBy",     limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",     limit: 100
    t.integer  "Sort",         limit: 4
  end

  create_table "wxpaylogs", primary_key: "ID", force: :cascade do |t|
    t.string   "OrderCode",   limit: 255
    t.string   "RandomCode",  limit: 255
    t.string   "OpenID",      limit: 255
    t.decimal  "Money",                   precision: 18, scale: 2
    t.string   "WxPayCode",   limit: 255
    t.boolean  "Status",      limit: 1
    t.datetime "CreateTime"
    t.string   "CreateBy",    limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",    limit: 100
    t.decimal  "PayDiscount",             precision: 18, scale: 2
    t.integer  "PayType",     limit: 4
    t.decimal  "Fee",                     precision: 10, scale: 2, default: 0.0
    t.integer  "PayProduct",  limit: 1,                            default: 1,   null: false
  end

  create_table "wxuserinfo", primary_key: "Id", force: :cascade do |t|
    t.string  "access_token",  limit: 512, null: false
    t.integer "expires_in",    limit: 4,   null: false
    t.string  "refresh_token", limit: 512, null: false
    t.string  "openid",        limit: 128, null: false
    t.string  "scope",         limit: 128, null: false
  end

  add_index "wxuserinfo", ["openid"], name: "idx_wxuserinfo_openid", using: :btree

  create_table "xy_test", force: :cascade do |t|
    t.string   "sn", limit: 10, default: "", null: false
    t.datetime "dt",                         null: false
  end

  create_table "天津小食品", id: false, force: :cascade do |t|
    t.string "分类",     limit: 255
    t.string "商品名称",   limit: 255
    t.string "条码",     limit: 255
    t.string "进货价",    limit: 255
    t.string "建议标价",   limit: 255
    t.string "9.65折价", limit: 255
    t.string "毛利",     limit: 255
  end

  create_table "天津饮料", id: false, force: :cascade do |t|
    t.string "商品分类",     limit: 255
    t.string "商品名称",     limit: 255
    t.string "商品编码",     limit: 255
    t.string "品牌",       limit: 255
    t.string "规格",       limit: 255
    t.string "单位",       limit: 255
    t.string "售价",       limit: 255
    t.string "采购价",      limit: 255
    t.string "0.965折后价", limit: 255
    t.string "毛利",       limit: 255
  end

  create_table "审计-商品出入库记录", id: false, force: :cascade do |t|
    t.string   "level2",           limit: 255
    t.string   "level3",           limit: 255
    t.string   "OrderCode",        limit: 255
    t.string   "PurchaseCode",     limit: 255
    t.string   "SupplierName",     limit: 255
    t.string   "Code",             limit: 100,                                 default: "", null: false
    t.string   "productname",      limit: 255
    t.string   "ProductBrandName", limit: 255
    t.integer  "ProductCount",     limit: 4
    t.decimal  "ProductPrice",                        precision: 18, scale: 2
    t.text     "OperationType",    limit: 4294967295
    t.string   "StorageName",      limit: 255
    t.datetime "CreateTime"
  end

  create_table "审计-订单商品出库记录", id: false, force: :cascade do |t|
    t.string   "StorageName",  limit: 255
    t.string   "ordercode",    limit: 255
    t.string   "code",         limit: 100,                          default: "", null: false
    t.string   "Name",         limit: 100,                                       null: false
    t.integer  "ProductCount", limit: 4
    t.decimal  "ProductPrice",             precision: 18, scale: 2
    t.datetime "CreateTime"
    t.string   "CreateBy",     limit: 100
  end

  create_table "审计-订单商品明细", id: false, force: :cascade do |t|
    t.string   "订单编号", limit: 255
    t.string   "收款类型", limit: 255
    t.string   "仓库名称", limit: 255
    t.string   "收货人",  limit: 255
    t.string   "收货电话", limit: 255
    t.string   "收货地址", limit: 255
    t.string   "商品编号", limit: 255
    t.string   "商品名称", limit: 255
    t.string   "规格",   limit: 255
    t.integer  "数量",   limit: 4,                            null: false
    t.integer  "退货数量", limit: 4
    t.decimal  "单价",               precision: 18, scale: 2
    t.decimal  "折后价",              precision: 18, scale: 2
    t.string   "订单状态", limit: 3
    t.datetime "创建时间"
  end

  create_table "审计-订单日志", id: false, force: :cascade do |t|
    t.string   "orderCODE",         limit: 255
    t.integer  "logtype",           limit: 4,          null: false
    t.datetime "operationdate",                        null: false
    t.string   "operationitcode",   limit: 255
    t.string   "operationusername", limit: 255
    t.text     "remark",            limit: 4294967295
  end

  create_table "导出订单商品明细", id: false, force: :cascade do |t|
    t.string   "ID",      limit: 36,                           default: "",  null: false
    t.string   "仓库名称",    limit: 255
    t.string   "订单编号",    limit: 255
    t.datetime "创建时间"
    t.datetime "提交时间"
    t.decimal  "订单折扣",                precision: 18, scale: 2, default: 1.0
    t.decimal  "app优惠金额",             precision: 18, scale: 2
    t.decimal  "积分抵扣金额",              precision: 18, scale: 2
    t.decimal  "优惠券减免金额",             precision: 18, scale: 2
    t.decimal  "订单总金额",               precision: 18, scale: 2
    t.decimal  "折扣金额",                precision: 18, scale: 2, default: 0.0
    t.decimal  "应收金额",                precision: 18, scale: 2
    t.decimal  "实收金额",                precision: 18, scale: 2
    t.integer  "付款方式",    limit: 4
    t.integer  "订单状态",    limit: 4
    t.string   "收款类型",    limit: 255
    t.string   "收货人",     limit: 255
    t.string   "收货人电话",   limit: 255
    t.string   "收货地址",    limit: 255
    t.string   "订单来源",    limit: 255
    t.boolean  "是否有退货",   limit: 1
    t.string   "订单留言",    limit: 255
    t.string   "客服备注",    limit: 255
    t.string   "用户电话",    limit: 255
    t.string   "所属销售",    limit: 255
    t.string   "商品名称",    limit: 100,                                        null: false
    t.string   "商品编号",    limit: 100,                          default: "",  null: false
    t.string   "品牌",      limit: 255
    t.string   "三级分类",    limit: 255
    t.string   "规格",      limit: 255
    t.integer  "数量",      limit: 4,                                          null: false
    t.decimal  "销售价格",                precision: 18, scale: 2
    t.decimal  "折扣价",                 precision: 18, scale: 2
    t.decimal  "商品销售总价",              precision: 28, scale: 2
    t.integer  "退货数量",    limit: 4
    t.integer  "缺货数量",    limit: 4,                            default: 0
  end

  create_table "所有订单明细", id: false, force: :cascade do |t|
    t.string   "订单编号",   limit: 255
    t.decimal  "商品总额",               precision: 18, scale: 2
    t.decimal  "应付总额",               precision: 18, scale: 2
    t.decimal  "折扣优惠",               precision: 18, scale: 2, default: 0.0
    t.decimal  "积分优惠",               precision: 18, scale: 2
    t.decimal  "优惠券优惠",              precision: 18, scale: 2
    t.decimal  "app立减",              precision: 18, scale: 2
    t.decimal  "扫码支付优惠",             precision: 18, scale: 2
    t.decimal  "实收金额",               precision: 18, scale: 2
    t.string   "订单状态",   limit: 3
    t.string   "收货人",    limit: 255
    t.datetime "提交时间"
    t.string   "二级分类",   limit: 255
    t.string   "三级分类",   limit: 255
    t.string   "商品编号",   limit: 100,                          default: ""
    t.string   "商品名称",   limit: 100
    t.decimal  "单价",                 precision: 18, scale: 2
    t.decimal  "折后单价",               precision: 18, scale: 2
    t.integer  "数量",     limit: 4
    t.integer  "退货数量",   limit: 4
  end

  create_table "查询所有后台发放的优惠券", id: false, force: :cascade do |t|
    t.string   "姓名",   limit: 255
    t.string   "手机号",  limit: 255
    t.datetime "起始日期"
    t.datetime "截至日期"
    t.decimal  "优惠金额",             precision: 18, scale: 2
    t.integer  "使用金额", limit: 4,                            default: 0
    t.string   "使用状态", limit: 3
    t.string   "来源",   limit: 2
    t.string   "赠券原因", limit: 255
    t.string   "兑换码",  limit: 30
    t.datetime "创建时间"
    t.string   "创建人",  limit: 100
  end

  create_table "订单记录", id: false, force: :cascade do |t|
    t.string   "ID",                         limit: 36,                                  default: "",  null: false
    t.string   "OrderCode",                  limit: 255
    t.string   "Message",                    limit: 255
    t.string   "Address",                    limit: 255
    t.string   "MemberCode",                 limit: 255
    t.decimal  "CostItem",                                      precision: 18, scale: 2
    t.decimal  "GiveawayTotal",                                 precision: 18, scale: 2, default: 0.0
    t.datetime "PayDatetime"
    t.integer  "OrderStatus",                limit: 4
    t.integer  "ShipStatus",                 limit: 4
    t.string   "LogiName",                   limit: 255
    t.string   "LogiCode",                   limit: 255
    t.decimal  "LogiPrice",                                     precision: 18, scale: 2
    t.string   "ShipName",                   limit: 255
    t.string   "ShipTel",                    limit: 255
    t.integer  "PayStatus",                  limit: 4
    t.decimal  "Money",                                         precision: 18, scale: 2
    t.decimal  "PointPrice",                                    precision: 18, scale: 2
    t.integer  "PayType",                    limit: 4
    t.string   "DepotId",                    limit: 36
    t.boolean  "IsHaveInvoice",              limit: 1
    t.string   "InvoiceTitle",               limit: 255
    t.boolean  "OpenedInovie",               limit: 1
    t.decimal  "ReceivedPrice",                                 precision: 18, scale: 2
    t.datetime "CreateTime"
    t.string   "CreateBy",                   limit: 100
    t.datetime "UpdateTime"
    t.string   "UpdateBy",                   limit: 100
    t.string   "UserID",                     limit: 36
    t.string   "ReceivePriceType",           limit: 255
    t.text     "ReceivePriceRemark",         limit: 4294967295
    t.string   "CouponCode",                 limit: 36
    t.decimal  "CouponPrice",                                   precision: 18, scale: 2
    t.boolean  "IsUrgency",                  limit: 1
    t.string   "DriverName",                 limit: 255
    t.string   "DriverMobile",               limit: 255
    t.boolean  "IsHaveReturn",               limit: 1
    t.decimal  "Discount",                                      precision: 18, scale: 2, default: 1.0
    t.datetime "SubmitDate"
    t.string   "CountyID",                   limit: 36
    t.string   "CustomerServiceConfirmType", limit: 255
    t.text     "CustomerServiceRemark",      limit: 4294967295
    t.string   "SalesmanID",                 limit: 36
    t.string   "CustomerServiceComment",     limit: 255
    t.decimal  "AppDiscount",                                   precision: 18, scale: 2
    t.string   "FromPlatform",               limit: 255
    t.string   "Longitude",                  limit: 255
    t.string   "Latitude",                   limit: 255
    t.boolean  "Isconfirmation",             limit: 1
    t.datetime "ReceivePriceTime"
    t.decimal  "OnlinePayDiscount",                             precision: 18, scale: 2
    t.integer  "DistributionState",          limit: 4
    t.string   "CompanyID",                  limit: 36
    t.decimal  "Commission",                                    precision: 18, scale: 2
  end

  create_table "财务-2015全部入库信息", id: false, force: :cascade do |t|
    t.text     "入库类型",  limit: 4294967295
    t.string   "仓库名称",  limit: 255
    t.string   "采购单号",  limit: 255
    t.string   "供应商名称", limit: 255
    t.datetime "时间"
    t.string   "二级分类",  limit: 255
    t.string   "三级分类",  limit: 255
    t.string   "商品编号",  limit: 100,                                 default: "", null: false
    t.string   "商品名称",  limit: 100,                                              null: false
    t.integer  "数量",    limit: 4
    t.decimal  "单价",                       precision: 18, scale: 2
  end

  create_table "财务-2015全部出库", id: false, force: :cascade do |t|
    t.text     "出库类型", limit: 4294967295
    t.string   "仓库名称", limit: 255
    t.string   "订单编号", limit: 255
    t.datetime "时间"
    t.string   "二级分类", limit: 255
    t.string   "三级分类", limit: 255
    t.string   "商品编号", limit: 100,                                 default: "", null: false
    t.string   "商品名称", limit: 100,                                              null: false
    t.integer  "数量",   limit: 4
    t.decimal  "单价",                      precision: 18, scale: 2
  end

  create_table "财务-订单商品明细", id: false, force: :cascade do |t|
    t.string   "订单编号",   limit: 255
    t.decimal  "商品总额",               precision: 18, scale: 2
    t.decimal  "应付总额",               precision: 18, scale: 2
    t.decimal  "折扣优惠",               precision: 18, scale: 2, default: 0.0
    t.decimal  "积分优惠",               precision: 18, scale: 2
    t.decimal  "优惠券优惠",              precision: 18, scale: 2
    t.decimal  "app立减",              precision: 18, scale: 2
    t.decimal  "扫码支付优惠",             precision: 18, scale: 2
    t.decimal  "实收金额",               precision: 18, scale: 2
    t.string   "订单状态",   limit: 3
    t.string   "收货人",    limit: 255
    t.string   "收货人电话",  limit: 255
    t.string   "收货地址",   limit: 255
    t.datetime "提交时间"
    t.string   "二级分类",   limit: 255
    t.string   "三级分类",   limit: 255
    t.string   "商品编号",   limit: 100,                          default: "",  null: false
    t.string   "商品名称",   limit: 100,                                        null: false
    t.decimal  "单价",                 precision: 18, scale: 2
    t.decimal  "折后单价",               precision: 18, scale: 2
    t.integer  "数量",     limit: 4,                                          null: false
    t.integer  "退货数量",   limit: 4
    t.integer  "缺货数量",   limit: 4,                            default: 0
  end

  add_foreign_key "actionlogmlcontents_0517", "actionlogs_0517", column: "MLParentID", primary_key: "ID", name: "FK_ActionLogMLContents_ActionLogs_MLParentID", on_update: :cascade, on_delete: :cascade
  add_foreign_key "advertisepics", "advertisepicgroups", column: "AdvertisePicGroupID", primary_key: "ID", name: "FK_AdvertisePics_AdvertisePicGroups_AdvertisePicGroupID"
  add_foreign_key "advertisepics", "fileattachments", column: "PhotoID", primary_key: "ID", name: "FK_AdvertisePics_FileAttachments_PhotoID"
  add_foreign_key "carts", "products", column: "ProductID", primary_key: "ID", name: "FK_Carts_Products_ProductID"
  add_foreign_key "carts", "users", column: "UserID", primary_key: "ID", name: "FK_Carts_Users_UserID"
  add_foreign_key "cities", "provinces", column: "ProvinceID", primary_key: "ID", name: "FK_Cities_Provinces_ProvinceID"
  add_foreign_key "companyphotoes", "fileattachments", column: "PhotoID", primary_key: "ID", name: "FK_CompanyPhotoes_FileAttachments_PhotoID"
  add_foreign_key "companyphotoes", "frameworkcompanies", column: "CompanyID", primary_key: "ID", name: "FK_CompanyPhotoes_FrameworkCompanies_CompanyID"
  add_foreign_key "companyproductgroups", "cities", column: "CityID", primary_key: "ID", name: "FK_CompanyProductGroupRelations_Cities_CityID"
  add_foreign_key "companyproductgroups", "frameworkcompanies", column: "FrameworkCompanys_ID", primary_key: "ID", name: "FK_e7a108b0378647e094bab5df461ba750"
  add_foreign_key "companyproductgroups", "productgroups", column: "ProductGroupID", primary_key: "ID", name: "FK_8acb29d185c8480594384b00a663d238"
  add_foreign_key "contractapproves", "frameworkcompanies", column: "CompanyID", primary_key: "ID", name: "FK_ContractApproves_FrameworkCompanies_CompanyID"
  add_foreign_key "contractapproves", "frameworkdepartments", column: "DepartmentID", primary_key: "ID", name: "FK_ContractApproves_FrameworkDepartments_DepartmentID"
  add_foreign_key "counties", "cities", column: "CityID", primary_key: "ID", name: "FK_Counties_Cities_CityID"
  add_foreign_key "dataprivileges", "frameworkdomains", column: "DomainID", primary_key: "ID", name: "FK_DataPrivileges_FrameworkDomains_DomainID"
  add_foreign_key "depotemployees", "depots", column: "DepotID", primary_key: "ID", name: "FK_DepotEmployees_Depots_DepotID"
  add_foreign_key "depotshelves", "depots", column: "DepotID", primary_key: "ID", name: "FK_DepotShelves_Depots_DepotID"
  add_foreign_key "depotshiftdetails", "depotshifts", column: "DepotShiftID", primary_key: "ID", name: "FK_DepotShiftDetails_DepotShifts_DepotShiftID"
  add_foreign_key "emaillogfileattachments", "emaillogs", column: "EmailLog_ID", primary_key: "ID", name: "FK_EmailLogFileAttachments_EmailLogs_EmailLog_ID", on_update: :cascade, on_delete: :cascade
  add_foreign_key "emaillogfileattachments", "fileattachments", column: "FileAttachment_ID", primary_key: "ID", name: "FK_853f9f1f1d744877a4f72107ecc184e4", on_update: :cascade, on_delete: :cascade
  add_foreign_key "emaillogs", "frameworkmodules", column: "FrameModuleID", primary_key: "ID", name: "FK_EmailLogs_FrameworkModules_FrameModuleID"
  add_foreign_key "enshrines", "products", column: "ProductID", primary_key: "ID", name: "FK_Enshrines_Products_ProductID"
  add_foreign_key "enshrines", "users", column: "UserID", primary_key: "ID", name: "FK_Enshrines_Users_UserID"
  add_foreign_key "financialsecondlevels", "financialfirstlevels", column: "FinancialFirstLevelID", primary_key: "ID", name: "FK_285c514286874cbdb2a33fda571706f4"
  add_foreign_key "frameworkactionmlcontents", "frameworkactions", column: "MLParentID", primary_key: "ID", name: "FK_FrameworkActionMLContents_FrameworkActions_MLParentID", on_update: :cascade, on_delete: :cascade
  add_foreign_key "frameworkactions", "frameworkmodules", column: "ModuleID", primary_key: "ID", name: "FK_FrameworkActions_FrameworkModules_ModuleID"
  add_foreign_key "frameworkareamlcontents", "frameworkareas", column: "MLParentID", primary_key: "ID", name: "FK_FrameworkAreaMLContents_FrameworkAreas_MLParentID", on_update: :cascade, on_delete: :cascade
  add_foreign_key "frameworkcompanymlcontents", "frameworkcompanies", column: "MLParentID", primary_key: "ID", name: "FK_0e6466d6b92c47a0a51e6775ff134c31", on_update: :cascade, on_delete: :cascade
  add_foreign_key "frameworkdepartmentmlcontents", "frameworkdepartments", column: "MLParentID", primary_key: "ID", name: "FK_d7d055ab9df546959dbcaab59645b46d", on_update: :cascade, on_delete: :cascade
  add_foreign_key "frameworkdepartments", "frameworkcompanies", column: "CompanyID", primary_key: "ID", name: "FK_FrameworkDepartments_FrameworkCompanies_CompanyID"
  add_foreign_key "frameworkdepartments", "frameworkdepartments", column: "ParentID", primary_key: "ID", name: "FK_FrameworkDepartments_FrameworkDepartments_ParentID"
  add_foreign_key "frameworkdomainmlcontents", "frameworkdomains", column: "MLParentID", primary_key: "ID", name: "FK_FrameworkDomainMLContents_FrameworkDomains_MLParentID", on_update: :cascade, on_delete: :cascade
  add_foreign_key "frameworkmenumlcontents", "frameworkmenus", column: "MLParentID", primary_key: "ID", name: "FK_FrameworkMenuMLContents_FrameworkMenus_MLParentID", on_update: :cascade, on_delete: :cascade
  add_foreign_key "frameworkmenus", "fileattachments", column: "IconID", primary_key: "ID", name: "FK_FrameworkMenus_FileAttachments_IconID"
  add_foreign_key "frameworkmenus", "frameworkdomains", column: "DomainID", primary_key: "ID", name: "FK_FrameworkMenus_FrameworkDomains_DomainID"
  add_foreign_key "frameworkmenus", "frameworkmenus", column: "ParentID", primary_key: "ID", name: "FK_FrameworkMenus_FrameworkMenus_ParentID"
  add_foreign_key "frameworkmodulemlcontents", "frameworkmodules", column: "MLParentID", primary_key: "ID", name: "FK_FrameworkModuleMLContents_FrameworkModules_MLParentID", on_update: :cascade, on_delete: :cascade
  add_foreign_key "frameworkmodules", "frameworkareas", column: "AreaID", primary_key: "ID", name: "FK_FrameworkModules_FrameworkAreas_AreaID"
  add_foreign_key "frameworkrolemlcontents", "frameworkroles", column: "MLParentID", primary_key: "ID", name: "FK_FrameworkRoleMLContents_FrameworkRoles_MLParentID", on_update: :cascade, on_delete: :cascade
  add_foreign_key "frameworkroles", "wfdefnodes", column: "WFDefNode_ID", primary_key: "ID", name: "FK_FrameworkRoles_WFDefNodes_WFDefNode_ID"
  add_foreign_key "frameworkuser", "fileattachments", column: "PhotoID", primary_key: "ID", name: "FK_FrameworkUser_FileAttachments_PhotoID"
  add_foreign_key "frameworkuser", "frameworkdepartments", column: "DepartmentID", primary_key: "ID", name: "FK_FrameworkUser_FrameworkDepartments_DepartmentID"
  add_foreign_key "frameworkuser", "wfdefnodes", column: "WFDefNode_ID", primary_key: "ID", name: "FK_FrameworkUser_WFDefNodes_WFDefNode_ID"
  add_foreign_key "frameworkuserrole", "frameworkroles", column: "FrameworkRole_ID", primary_key: "ID", name: "FK_FrameworkUserRole_FrameworkRoles_FrameworkRole_ID", on_update: :cascade, on_delete: :cascade
  add_foreign_key "frameworkuserrole", "frameworkuser", column: "FrameworkUserBase_ID", primary_key: "ID", name: "FK_FrameworkUserRole_FrameworkUser_FrameworkUserBase_ID", on_update: :cascade, on_delete: :cascade
  add_foreign_key "functionprivileges", "frameworkmenus", column: "MenuItemId", primary_key: "ID", name: "FK_FunctionPrivileges_FrameworkMenus_MenuItemId", on_update: :cascade, on_delete: :cascade
  add_foreign_key "jhbmailinfoes", "jhbmailtypes", column: "MailTypeID", primary_key: "ID", name: "FK_JHBMailInfoes_JHBMailTypes_MailTypeID"
  add_foreign_key "orderproducts", "orders", column: "OrderID", primary_key: "ID", name: "FK_OrderProducts_Orders_OrderID"
  add_foreign_key "orderproducts", "products", column: "ProductID", primary_key: "ID", name: "FK_OrderProducts_Products_ProductID"
  add_foreign_key "orders", "depots", column: "DepotId", primary_key: "ID", name: "FK_Orders_Depots_DepotId"
  add_foreign_key "orders", "users", column: "UserID", primary_key: "ID", name: "FK_Orders_Users_UserID"
  add_foreign_key "outofstoragedetails", "depots", column: "DepotId", primary_key: "ID", name: "FK_OutOfStorageDetails_Depots_DepotId"
  add_foreign_key "productimgs", "fileattachments", column: "PhotoID", primary_key: "ID", name: "FK_ProductImgs_FileAttachments_PhotoID"
  add_foreign_key "productinfoes", "productgroups", column: "ProductGroupsID", primary_key: "ID", name: "FK_ProductInfoes_ProductGroups_ProductGroupsID"
  add_foreign_key "productlogs", "fileattachments", column: "PhotoID", primary_key: "ID", name: "productlogs_ibfk_1"
  add_foreign_key "productlogs", "productgroups", column: "ProductGroupsID", primary_key: "ID", name: "productlogs_ibfk_2"
  add_foreign_key "products", "fileattachments", column: "PhotoID", primary_key: "ID", name: "FK_Products_FileAttachments_PhotoID"
  add_foreign_key "products", "productgroups", column: "ProductGroupsID", primary_key: "ID", name: "FK_Products_ProductGroups_ProductGroupsID"
  add_foreign_key "producttaggroups", "tags", column: "TagID", primary_key: "ID", name: "FK_ProductTagGroups_Tags_TagID"
  add_foreign_key "purchasedetails", "products", column: "ProductID", primary_key: "ID", name: "FK_PurchaseDetails_Products_ProductID"
  add_foreign_key "purchases", "depots", column: "DepotID", primary_key: "ID", name: "FK_Purchases_Depots_DepotID"
  add_foreign_key "purchases", "suppliers", column: "SupplierID", primary_key: "ID", name: "FK_Purchases_Suppliers_SupplierID"
  add_foreign_key "returnpurchases", "purchases", column: "PurchaseID", primary_key: "ID", name: "FK_ReturnPurchases_Purchases_PurchaseID"
  add_foreign_key "searchconditions", "frameworkuser", column: "UserID", primary_key: "ID", name: "FK_SearchConditions_FrameworkUser_UserID", on_update: :cascade, on_delete: :cascade
  add_foreign_key "shelfproductrelations", "depotshelves", column: "ShelvesID", primary_key: "ID", name: "FK_ShelfProductRelations_DepotShelves_ShelvesID"
  add_foreign_key "shelfproductrelations", "products", column: "ProductID", primary_key: "ID", name: "FK_ShelfProductRelations_Products_ProductID"
  add_foreign_key "streets", "counties", column: "CountyID", primary_key: "ID", name: "FK_Streets_Counties_CountyID"
  add_foreign_key "supplieradvances", "frameworkcompanies", column: "CompanyID", primary_key: "ID", name: "FK_SupplierAdvances_FrameworkCompanies_CompanyID"
  add_foreign_key "supplieradvances", "suppliers", column: "SupplierID", primary_key: "ID", name: "FK_SupplierAdvances_Suppliers_SupplierID"
  add_foreign_key "supplierproductbrandrelations", "suppliers", column: "SupplierID", primary_key: "ID", name: "FK_SupplierProductBrandRelations_Suppliers_SupplierID"
  add_foreign_key "taggroups", "productgroups", column: "ProductGroupID", primary_key: "ID", name: "FK_TagGroups_ProductGroups_ProductGroupID"
  add_foreign_key "tags", "taggroups", column: "TagGroupID", primary_key: "ID", name: "FK_Tags_TagGroups_TagGroupID"
  add_foreign_key "useraddresses", "users", column: "UserID", primary_key: "ID", name: "FK_UserAddresses_Users_UserID"
  add_foreign_key "users", "fileattachments", column: "PhotoID", primary_key: "ID", name: "FK_Users_FileAttachments_PhotoID"
  add_foreign_key "users", "salesmen", column: "SalesmanID", primary_key: "ID", name: "FK_Users_Salesmen_SalesmanID"
  add_foreign_key "users_copy", "fileattachments", column: "PhotoID", primary_key: "ID", name: "users_copy_ibfk_1"
  add_foreign_key "users_copy", "salesmen", column: "SalesmanID", primary_key: "ID", name: "users_copy_ibfk_2"
  add_foreign_key "wfdeflinks", "wfdefnodes", column: "EndNodeID", primary_key: "ID", name: "FK_WFDefLinks_WFDefNodes_EndNodeID"
  add_foreign_key "wfdeflinks", "wfdefnodes", column: "StartNodeID", primary_key: "ID", name: "FK_WFDefLinks_WFDefNodes_StartNodeID"
  add_foreign_key "wfdefnodes", "wfdefinations", column: "WFDefinationID", primary_key: "ID", name: "FK_WFDefNodes_WFDefinations_WFDefinationID"
end
