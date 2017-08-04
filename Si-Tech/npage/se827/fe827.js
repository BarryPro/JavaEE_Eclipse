var titles = {
		 
		 /*2014/08/05 14:51:13 gaopeng 关于下发一级客服省级业务支撑系统2014年07月批次配合改造要求的通知
		 	MobileMarket MM订购黑名单查询
		 */
		 title_41_001 : new Array('返回结果','是否黑名单状态','黑名单有效期'),
		 /*2014/08/05 14:51:13 gaopeng 关于下发一级客服省级业务支撑系统2014年07月批次配合改造要求的通知
		 	MobileMarket MM订购关系查询
		 */
		 title_41_002 : new Array('返回结果','订单数量','SP企业代码','SP中该服务的服务代码','应用ID','计费用户手机号','使用用户的手机号','订购服务的时间','支付方式','定购渠道标识','订单价格','操作类型标识','订单过期时间','订单唯一编号','订单标识','用户定购的服务类型','AP名称','应用名称','道具名称'),
		 /*2014/08/05 14:51:13 gaopeng 关于下发一级客服省级业务支撑系统2014年07月批次配合改造要求的通知
		 	MobileMarket  e828 MM订购黑名单设置
		 */
		 
		 
		 
		 /**
		  * heja 2015-7-2 17:12:45 关于下发一级客服省级业务支撑系统2015年06月批次配合改造要求的通知 添加
		  *
		  */
		 //用户订购异常行为核查
		 title_41_003 : new Array('序号','用户号码','订单号','订购时间','应用ID','应用名称','APID','APCODE','AP名称','渠道ID','渠道名称','业务ID（计费点ID）','业务代码(计费点代码）','业务名称（计费点名称）','计费类型','订购金额','IMEI','用户终端机型','计费SDK版本','强弱联网订购','累计登陆次数','累计在线时长','是否有启动日志','是否有计费页面点击日志','核查结果'),
		 //用户短信上下行日志查询
		 title_41_004 : new Array('序号','发送时间','资费代码','道具名称','道具金额','应用ID','应用名称','用户手机号码','信息类型','短信内容','备注'),
     //用户轨迹行为核查
		 title_41_005 : new Array('序号','订单ID','用户号码','应用ID','应用名称','用户行为','行为时间'),		 
		 //手动动漫  - 包月配额查询
		 title_95_006 : new Array('手机号码','业务名称','起始时间','到期时间','总配额','已使用配额','剩余配额'),
		 //咪咕动漫  - 漫币获取记录查询
		 title_95_007 : new Array('用户帐号','获取方式','获取数量（分）','获取时间','漫币有效期','消费范围'),		 
		 //咪咕动漫  - 漫币消费记录查询
		 title_95_008 : new Array('用户帐号','消费数量（分）','消费产品名','消费时间'),		 
		 //咪咕动漫  - 漫币代购记录查询
		 title_95_009 : new Array('用户账户','代购数量（分）','代购类型','代购方','接收方','代购时间','消费范围'),		 
		 
		 
		 //包月订购关系历史记录查询
		 title_95_010 : new Array('产品ID','产品名称','CP名称','操作时间','操作方式','接入方式','短信接入码','渠道名称','操作结果'),
		 //011	消费记录查询
		 title_95_011 : new Array('业务/内容ID','业务/内容名称','产品ID','产品名称','消费金额','消费方式','使用方式','cp名称','渠道名称','支付方式','BOSSID'),
		 //012	用户账户查询 
		 title_95_012 : new Array('注册时间','归属省份','归属地市','漫币余额','业务名称','应优惠','已优惠','剩余使用量'),
		 //013	短信上下行查询
		 title_95_013 : new Array('序号','手机号码','上/下行','接入号','发送时间'),
		 //014	核查
		 title_95_014 : new Array('核查结果'),
   		 
		 //手机支付  - 订购关系查询
		 title_64_007 : new Array('姓名','别名','手机号','实名标识','用户类别','和包账户状态','登录密码修改标志','支付密码修改标志','和聚宝余额','和聚宝总收益','和聚宝日收益','和包账户','和包刷卡','和包刷卡ID','和包账户现金余额','和包账户充值卡余额','客户状态','和包刷卡属性','和包刷卡卡状态','会员','信用级别'),
		 //手机支付  - 账户充值查询
		 title_64_008 : new Array('交易日志号','记账日期','交易时间','订单编号','交易类别','交易渠道','冻结/解冻金额(元)','交易金额(元)','余额(元)','商户编号'),
		 //手机支付  - 自动充话费查询
		 title_64_009 : new Array('手机号','是否签约','协议编号','协议类型','代扣方式','代扣条件','短信提醒标志','卡通补款标志','协议生效日期','最后一次操作维护类型','协议失效日期','最后一次操作请求时间','协议维护渠道'),
		 //手机支付  - 实名认证关联手机号查询
		 title_64_010 : new Array('用户姓名','认证手机号码','认证方式','认证渠道','认证时间'),
		 //手机支付  - 交流量明细查询
		 title_64_011 : new Array('支付号码','被充值号码','充流量时间','支付金额(元)','流量包','充流量渠道','充值状态','支付状态','充流量订单号','远程订单号','BOSS流水号'),
		 //通信账户支付  - 短信上下行查询
		 title_70_002 : new Array('短信类型','下发时间','上下行长号码','短信内容','接收时间'),
		 //通信账户支付  - 黑名单查询
		 title_70_003 : new Array('添加时间','过期时间','名单类型','添加原因','添加人'),
		 //通信账户支付  - 话费业务查询
		 title_70_004 : new Array('平台流水号','平台日期','平台时间','交易状态','订单号','银行号','商户号','商户名称','商品号','商品名称','交易金额'),
		 //139邮箱  - 139邮箱账号信息查询
		 title_62_001 : new Array('手机号码','邮箱别名','通行证号','手机号码归属地','邮箱版本','用户邮箱状态','上次开通时间','上次开通方式','月赠送自写短信','当月已使用自写短信','月赠送自写彩信','当月已使用自写彩信','目前通讯录条数','登陆短信通知状态','邮件到达通知'),
		 //139邮箱  - 营销类邮件屏蔽查询
		 title_62_002 : new Array('手机号码','用户级别','归属地','用户姓名','用户所属公司','推荐人姓名','说明备注','创建时间'),
		 //手机导航  - 和地图订购关系履历查询
		 title_54_001 : new Array('查询结果记录行号','用户手机号码','业务编码','子业务编码','套餐编码','订购方式','市编码','省编','来源','二级来源','订购发起时间','订购生效时间','动作类型','操作成功标志','操作结果码','附加信息','开发厂商','版本类别','操作时间'),
		 //手机导航  - 和地图订购关系状态查询
		 title_54_002 : new Array('查询结果记录行号','用户手机号码','业务编码','子业务编码','套餐编码','订购方式','开始时间','结束时间','变更时间','动作类型','来源','二级来源','开户省编码','开户市编码','开发厂商','版本类别','操作时间'),
		 //手机导航  - 和地图订购黑名单查询
		 title_54_003 : new Array('查询结果记录序号','用户手机号码','被屏蔽业务','最后屏蔽时间'),
		 //12582业务  - 订购历史查询
		 title_130_001 : new Array('查询结果记录序号','用户手机号码','业务名称','订购行为','产品编码','时间'),
		 //12582业务  - 内容定制关系查询
		 title_130_002 : new Array('查询结果记录序号','用户手机号码','业务名称','业务内容版本','关键字','产品编码','订购时间'),
		 //12582业务  - 下发历史记录查询
		 title_130_003 : new Array('查询结果记录序号','用户手机号码','业务名称','类型','下发结果','下发时间'),
		 //12582业务  - 业务黑名单查询
		 title_130_004 : new Array('查询结果记录序号','用户手机号码','被屏蔽类型','产品名称','被屏蔽原因','被屏蔽时间'),
		 //12580业务  - 12580订购关系查询
		 title_50_001 : new Array('用户手机号码','业务分类','业务名称','业务资费','业务类型','操作时间'),
		 //12580业务  - 历史记录查询
		 title_50_002 : new Array('用户手机号码','业务名称','操作类型','业务渠道','操作时间'),
		 //12580业务  - 点播记录查询
		 title_50_003 : new Array('用户手机号码','业务名称','业务类型','业务渠道','操作时间','下发内容'),
		 //12590系统平台  - 拨打记录查询
		 title_121_001 : new Array('查询结果记录序号','SP名称','业务名称','是否为媒体业务','主叫号码','被叫号码','通话时长（秒）','计费费用（元）','通话开始时间','通话结束时间','按键查询','企业代码','企业名称','业务名称','客服热线1','客服热线2'),
		 //12590系统平台  - 客户端业务使用查询
		 title_121_002 : new Array('查询结果记录序号','用户号码','业务商','渠道商','资源名称','计费模式','资费（元）','计费代码','计费时间','省份','计费状态','企业代码','业务接入号','计费代码名称','计费短信端口','计费短信内容'),
		 //12590系统平台  - 用户短信上下行查询
		 title_121_003 : new Array('查询结果记录序号','用户号码','短信类型','短信端口号','短信内容','短信时间','计费金额（元）','短信业务名称','公司简称','公司全称','企业代码','企业号码'),
		 //12590系统平台  - 黑名单查询
		 title_121_004 : new Array('是否屏蔽','提出省份','有效开始时间','有效结束时间'),
		 
		 
		 title_x_x : new Array('','','','','','','','','','','','','','','','','',''),
		 
		 title_121_005 : new Array('查询结果记录序号','用户手机号码','业务提供商','业务名称','业务类型','消费金额','使用时间','客服电话'),
		 title_121_006 : new Array('查询结果记录序号','用户手机号码','业务提供商','业务名称','业务类型','消费金额','使用时间','客服电话'),
		 title_121_007 : new Array('查询结果记录序号','用户手机号码','业务提供商','业务名称','业务类型','消费金额','开始时间','结束时间','客服电话'),
		 title_121_008 : new Array('是否灰名单','提出省份','有效开始时间','有效结束时间'),
		 
		 title_41_006 : new Array('消息类型','版本号','返回码','返回消息','日限额','月限额'),
		 title_41_007 : new Array('消息类型','版本号','返回码','返回消息','显示标志','设置时间'),		 
		 
		 title_82_009 : new Array('注册时间','注册账号','更新时间','用户状态','业务状态','用户归属地','影币账户余额信息','充值卡余额信息','支付宝余额信息','虚拟金币余额信息'),		 
		 title_82_010 : new Array('查询结果记录序号','产品代码','产品名称','节目ID','节目名称','观看时间','计费类型','计费金额'),		 
		 title_82_011 : new Array('查询结果记录序号','充值ID','充值时间','充值金额','操作类型','充值类型'),		 
		 
		 title_41_008 : new Array('序号','流水号','充值面额','实际支付','充值方式','充值状态','充值时间'),		 
		 title_41_009 : new Array('查询结果记录序号','用户手机号码','发送时间','任务名称','类型','信息内容'),		 
		 
		 title_72_008 : new Array('查询结果记录序号','手机号码','渠道名称','渠道代码','发送时间','上下行标志','短信内容','短信端口','短信状态','返回描述'),		 
	
		 
		 title_159_001 : new Array('业务类型关键字','服务器处理结果','用户手机号','订单号','流量包ID','流量包类型','流量包名','流量包使用地（国家地区）','运营商名','有效时间（天）','流量包总流量','剩余流量（MB）','已用流量（MB）','激活时间','最晚激活时间','剩余天数','产品价格','流量包的订购及使用状态','退订状态'),
		 title_159_002 : new Array('业务类型关键字','服务器处理结果','状态类型','状态值','状态描述','状态时间'),
		 
     title_42_001 : new Array('查询结果记录序号','用户手机号码','被屏蔽业务','最后屏蔽时间'),
     title_42_002 : new Array('查询结果记录序号','手机号码','书名','卷名','章名','内容类型','阅读时间','订购方式','阅读途径'),
     title_42_003 : new Array('查询结果记录序号','书名','作家','授权方','推荐分类','作品长度','资费说明'),
     title_42_004 : new Array('查询结果记录序号','手机号码','书券ID','书券名','领取时间','消费开始时间','消费结束时间','单价(元)','余额(元)','最近消费时间'),			
     title_42_005 : new Array('查询结果记录序号','手机号码','栏目名称','产品ID','产品名称','资费说明','订购时间','退订时间','最近订/退途径','状态','暂停时间','恢复时间','渠道ID'),
     title_42_006 : new Array('查询结果记录序号','手机号码','名称','卷名','章节名','订购时间','内容类型','订购途径','资费说明','计费方式','原价(元)','应付金额(元)','书券抵扣(元)','实付金额(元)','消费方式','产品ID','是否赠送给好友','好友手机号码','渠道ID'),
     title_42_007 : new Array('查询结果记录序号','设备ID','厂商名称','计费号码','内卡卡号','绑定状态','绑定时间','绑定方式','解绑时间','解绑方式','IMEI'),
     title_42_008 : new Array('序号','流水号','充值面额（分）','实际支付','充值方式','充值状态','充值时间'),
     title_42_009 : new Array('查询结果记录序号','用户手机号码','发送时间','任务名称','类型','信息内容'),
     
     title_57_001 : new Array('查询结果记录序号','手机号码','名单级别','黑名单来源','创建时间'),
     title_57_002 : new Array('查询结果记录序号','操作时间','手机号码','业务代码','业务名称','业务类型','套餐名称','支付方式','合作方代码','合作方名称','基本价格(元)','道具代码','道具名称','计费方式','实收费用(元)','折扣策略'),
     title_57_003 : new Array('查询结果记录序号','用户ID','套餐订购时间','套餐ID','套餐名称','渠道ID','渠道名称','订购方式','订购状态'),
     title_57_004 : new Array('查询结果记录序号','状态','查询类型','结果状态','用户类型','用户手机号','套餐名称','具体操作','渠道id','套餐id','渠道名称','金额(元)','操作时间'),
     title_57_005 : new Array('查询结果记录序号','操作时间','合作方代码','充值代码','充值或消费金额(元)','渠道名称','充值方式','退费标志'),
     title_57_006 : new Array('查询结果记录序号','类型','结果状态','用户类型','用户手机号','点数'),
     title_57_007 : new Array('查询结果记录序号','业务代码','合作方代码','业务名称','游戏业务类型','支付类型','计费方式','游戏业务状态','生效日期','失效日期','套餐ID','业务套餐名称','金额(元)','计费单位'),
     title_57_008 : new Array('查询结果记录序号','用户手机号','号码来源','加入屏蔽时间'),
     
     /*2014/08/05 14:15:28 gaopeng 关于下发一级客服省级业务支撑系统2014年07月批次配合改造要求的通知
     	用户信息查询
     */
     title_57_009 : new Array('注册时间','用户伪码','邮箱','自定义帐号'),
      /*2014/08/05 14:15:28 gaopeng 关于下发一级客服省级业务支撑系统2014年07月批次配合改造要求的通知
     	灰名单查询
     */
     title_57_010 : new Array('查询结果记录序号','手机号码','灰名单来源','创建时间'),
     /*2014/08/05 14:15:28 gaopeng 关于下发一级客服省级业务支撑系统2014年07月批次配合改造要求的通知
     	灰名单查询
     */
     title_57_011 : new Array('核查结果'),
     /*2014/08/05 14:15:28 gaopeng 关于下发一级客服省级业务支撑系统2014年07月批次配合改造要求的通知
     	使用记录查询
     */
     title_57_012 : new Array('业务代码','业务名称','操作时间','操作类型'),
     
     
     title_64_001 : new Array('现金账户余额(元)','现金账户可用可提现余额(元)','现金账户不可用余额(元)','现金账户可用不可提现余额(元)','充值卡账户余额(元)','充值卡账户不可用余额(元)','充值卡账户可用余额(元)','钱包帐户余额(元)','电子券余额(元)','不可用总余额(元)','可用总余额(元)'),
     title_64_002 : new Array('支付手机号码','缴费手机号码','缴费时间','缴费金额(元)','缴费渠道','缴费状态','BOSS返回码','错误原因','缴费模块内部订单号','支付订单号','BOSS流水号','有无账户标志'),
     title_64_003 : new Array('营销工具编号','营销工具名称','参与活动编号','参与活动名称','营销工具面额(元)','营销工具余额(元)','生效日期','失效日期','发行方编号','发行方名称 ','交易日期 ','电子券状态','内部订单号','商户编号','商户名称','转赠方号码/转让方号码','受赠方号码/购买方号码','折扣','交易金额(元)'),
     title_64_004 : new Array('订单日期','下单日期','商户编号','订单编号','消费金额(元)','订单状态','授权号码','商户名称','支付类型'),
     title_64_005 : new Array('买家','商户编号','订单编号','交易时间','交易总价(元)','现金金额(元)','充值卡金额(元)','失效时间','最后记账日期','代金券金额(元)','代金券张数','商户名称','商品名称','支付类型','订单状态','用户支付时间','支付方式','订单类型','业务受理渠道','内部订单号','充值订单号'),
     title_64_006 : new Array('手机号','账户类型','姓名','证件类型','证件号码','开户日期','开户时间','销户日期','销户时间','开户渠道','销户渠道','账户状态'),
     
     title_70_007 : new Array('手机号','购买时间','商户名称','商品名称','金额(分)','业务代码','商品类型'),
     
     title_72_001 : new Array('查询结果记录序号','手机号码','黑名单类型','黑名单创建时间','黑名单备注信息','黑名单操作结果'),
     title_72_002 : new Array('查询结果记录序号','业务ID','业务名称','歌曲名称','歌手名称','计费类型','资费（元）','下载时间','操作方式','操作渠道'),
     title_72_003 : new Array('查询结果记录序号','会员级别','操作类型','操作方式','操作渠道','操作时间'),
     title_72_004 : new Array('查询结果记录序号','业务名称','业务类型','操作类型','操作方式','操作渠道','操作时间','操作结果'),
     title_72_005 : new Array('查询结果记录序号','业务ID','业务名称','歌曲名称','歌手名称','计费类型','资费(元)','下载时间','操作方式','操作渠道','下载状态'),
     title_72_006 : new Array('查询结果记录序号','歌曲ID','歌曲名称','歌手名称','资费(元)','订购类型','订购渠道','订购时间', '返回码', '返回描述'),
     title_72_007 : new Array('查询结果记录序号','省份','操作人员','操作时间'),
     
     title_82_001 : new Array('查询结果记录序号','用户手机号码','被屏蔽业务','最后设置时间'),
     title_82_002 : new Array('查询结果记录序号','产品代码','产品名称','企业代码','企业名称','计费类型','操作途径','操作记录','操作时间','操作人'),
     title_82_003 : new Array('查询结果记录序号','产品代码','产品名称','节目ID','节目名称','观看时间','计费类型','计费金额(分)','播放时长(秒)'),
     /*2014/08/05 9:43:20 gaopeng 关于下发一级客服省级业务支撑系统2014年07月批次配合改造要求的通知 
     	修改 是否支持LTE 新增 android客户端适配
     */
     title_82_004 : new Array('查询结果记录序号','手机型号','手机品牌','屏幕尺寸(宽*高)','是否支持LTE','是否支持直播观看','是否支持下载观看','富媒体客户端适配','简化UI适配','android客户端适配'),
     title_82_005 : new Array('查询结果记录序号','查询结果'),
     title_82_006 : new Array('查询结果记录序号','查询结果','验证日期','图形验证码有效期'),
     
     /*2014/08/05 10:06:17 gaopeng 关于下发一级客服省级业务支撑系统2014年07月批次配合改造要求的通知 
     	使用记录查询
     */
     title_82_007 : new Array('查询结果记录序号','开始时间','产品名称','节目ID','节目名称','使用时长','计费类型','流量','网络类型','播放方式','入口类型','产品ID'),
     /*2014/08/05 10:06:17 gaopeng 关于下发一级客服省级业务支撑系统2014年07月批次配合改造要求的通知 
     	业务黑名单查询
     */
     title_82_008 : new Array('查询结果记录序号','查询结果','加入黑名单的日期','黑名单有效期'),
     
     title_40_001 : new Array('套餐标识','套餐名称','套餐状态','频道标识','频道名称'),
     title_40_002 : new Array('业务功能','操作时间','操作结果','外部操作内容','接口类型','套餐或频道ID','请求来源'),
     title_40_003 : new Array('操作时间','操作结果','内部错误码','外部错误码','接口类型','频道ID','终端能力标识','终端版本号', '广电会话号'),
     title_40_004 : new Array('操作类型','套餐ID','操作时间','操作结果','内部错误码','请求来源','外部错误码','接口类型','交易流水号','操作流水号', '终端能力标识', '终端版本号', '广电会话号'),
     title_40_005 : new Array('操作时间','请求类型','操作结果','内部错误码','请求来源','外部错误码','接口类型','交易流水号', '操作流水号'),
     title_40_006 : new Array('操作时间','操作类型','内部错误码','外部错误码','操作结果','接口类型','终端能力标识','终端版本号'),
     title_40_007 : new Array('操作时间','操作结果','内部错误码','外部错误码','CELLID','SGDDID','LOCFLAG','LBAP结果码','GIS结果码'),	
     title_40_008 : new Array('操作时间','频道ID','套餐ID','操作结果','内部错误码','外部错误码','终端能力标识','终端版本号', '广电会话号'),	
     title_40_009 : new Array('操作时间','操作结果','内部错误码','外部错误码','请求来源','终端能力标识','终端版本号'),
     title_40_010 : new Array('操作时间','操作结果','内部错误码','外部错误码','终端能力标识','终端版本号'),
     title_40_011 : new Array('套餐标识','订购状态','订购/退订时间','订购渠道'),
     
     title_95_001 : new Array('查询结果记录序号','作品名称','点播时间','作品金额', 'CP名称', '渠道ID', '渠道名称','局数据ID'),
     title_95_002 : new Array('查询结果记录序号','产品ID','产品名称','订购状态', '订购时间', '到期时间', '订购渠道'),
     title_95_003 : new Array('用户号码','屏蔽类型','屏蔽状态','同步来源','操作员', '操作时间', '操作结果'),
     /*2014/08/05 9:03:22 gaopeng e827 异常行为用户查询 */
     title_95_004 : new Array('手机号码','操作日期','操作方式','管控方式','同步来源','操作员','备注'),
     /*2014/08/05 9:03:22 gaopeng e827 用户接收状态查询 */
     title_95_005 : new Array('操作结果'),
     /*2014/08/05 9:03:22 gaopeng e828 业务补发 */
     //title_95_006 : new Array('查询结果'),
     /*2014/08/05 9:03:22 gaopeng e828 异常行为用户操作 */
     //title_95_007 : new Array('操作结果'),
     /*2014/08/05 9:03:22 gaopeng e828 用户接收状态恢复 */
     //title_95_008 : new Array('操作结果'),

     
     title_70_001 : new Array('手机号','购买时间','商户名称','商品名称', '金额', '业务代码', '商品类型'),
     title_99_001 : new Array('序号','业务名称','主叫号码','主叫归属省', '被叫号码', 'SP名称', '联系方式','通话开始时间','通话结束时间','通话时长','计费类型','资费','信息费'),
     title_99_002 : new Array('序号','业务名称','业务承载类型','业务ID', '具体内容名称', '所属合作方', '联系方式','订购时间','订购状态','订购生效时间','订购失效时间','计费类型','业务资费','信息费','计费状态','渠道名称'),
     
     title_47_001 : new Array('序号','业务名称','内容名称','SP业务代码', 'SP企业代码', '发送时间', '资费（分）'),
     title_47_002 : new Array('序号','业务名称','业务承载类型（业务运行平台）','业务ID','具体内容名称', '合作方名称', '客服电话', '订购时间','订购状态','订购生效时间','购失效时间','计费类型','业务资费（单位：分）','信息费（单位：元）','计费状态','渠道名称'),
     title_47_003 : new Array('序号','手机号码','操作人','添加时间', '屏蔽终止时间')
     
};

function cntCode (code,name) {
	this.code = code;
	this.name = name;
}

/*
 *	tdObjArr是一行中需要转换的td集合，arrs为td所对应的数组的集合
 */
function setTdVals(tdObjArr,arrs) {
	for(var i=0,len=tdObjArr.length;i<len;i++) {
		var tdVal = tdObjArr[i].text();
		for(var j=0,len2=arrs[i].length;j<len2;j++) {
			var obj = arrs[i][j];
			if(obj.code == tdVal) {
				tdObjArr[i].text(obj.name);	
				break;
			} 
		}
	}	
} 
//无线音乐
{
	//服务状态编码表 music_001_1_array
	{
	var music_001_1_array=new Array();
	music_001_1_array.push(new cntCode('1','未屏蔽任何业务'));
	music_001_1_array.push(new cntCode('2','短信业务已被屏蔽'));
	music_001_1_array.push(new cntCode('3','彩信业务已被屏蔽'));
	music_001_1_array.push(new cntCode('4','短信彩信业务都已被屏蔽'));
	music_001_1_array.push(new cntCode('5','未发送任何业务'));
	music_001_1_array.push(new cntCode('6','短信业务已被发送'));
	music_001_1_array.push(new cntCode('7','彩信业务已被发送'));
	music_001_1_array.push(new cntCode('8','短信彩信业务都已被发送'));
	
	music_001_1_array.push(new cntCode('1/1','未屏蔽任何业务/未屏蔽任何业务'));
	music_001_1_array.push(new cntCode('1/2','未屏蔽任何业务/短信业务已被屏蔽'));
	music_001_1_array.push(new cntCode('1/3','未屏蔽任何业务/彩信业务已被屏蔽'));
	music_001_1_array.push(new cntCode('1/4','未屏蔽任何业务/短信彩信业务都已被屏蔽'));
	music_001_1_array.push(new cntCode('1/5','未屏蔽任何业务/未发送任何业务'));
	music_001_1_array.push(new cntCode('1/6','未屏蔽任何业务/短信业务已被发送'));
	music_001_1_array.push(new cntCode('1/7','未屏蔽任何业务/彩信业务已被发送'));
	music_001_1_array.push(new cntCode('1/8','未屏蔽任何业务/短信彩信业务都已被发送'));
	
	music_001_1_array.push(new cntCode('2/1','短信业务已被屏蔽/未屏蔽任何业务'));
	music_001_1_array.push(new cntCode('2/2','短信业务已被屏蔽/短信业务已被屏蔽'));
	music_001_1_array.push(new cntCode('2/3','短信业务已被屏蔽/彩信业务已被屏蔽'));
	music_001_1_array.push(new cntCode('2/4','短信业务已被屏蔽/短信彩信业务都已被屏蔽'));
	music_001_1_array.push(new cntCode('2/5','短信业务已被屏蔽/未发送任何业务'));
	music_001_1_array.push(new cntCode('2/6','短信业务已被屏蔽/短信业务已被发送'));
	music_001_1_array.push(new cntCode('2/7','短信业务已被屏蔽/彩信业务已被发送'));
	music_001_1_array.push(new cntCode('2/8','短信业务已被屏蔽/短信彩信业务都已被发送'));	
	
	music_001_1_array.push(new cntCode('3/1','彩信业务已被屏蔽/未屏蔽任何业务'));
	music_001_1_array.push(new cntCode('3/2','彩信业务已被屏蔽/短信业务已被屏蔽'));
	music_001_1_array.push(new cntCode('3/3','彩信业务已被屏蔽/彩信业务已被屏蔽'));
	music_001_1_array.push(new cntCode('3/4','彩信业务已被屏蔽/短信彩信业务都已被屏蔽'));
	music_001_1_array.push(new cntCode('3/5','彩信业务已被屏蔽/未发送任何业务'));
	music_001_1_array.push(new cntCode('3/6','彩信业务已被屏蔽/短信业务已被发送'));
	music_001_1_array.push(new cntCode('3/7','彩信业务已被屏蔽/彩信业务已被发送'));
	music_001_1_array.push(new cntCode('3/8','彩信业务已被屏蔽/短信彩信业务都已被发送'));	
	
	music_001_1_array.push(new cntCode('4/1','短信彩信业务都已被屏蔽/未屏蔽任何业务'));
	music_001_1_array.push(new cntCode('4/2','短信彩信业务都已被屏蔽/短信业务已被屏蔽'));
	music_001_1_array.push(new cntCode('4/3','短信彩信业务都已被屏蔽/彩信业务已被屏蔽'));
	music_001_1_array.push(new cntCode('4/4','短信彩信业务都已被屏蔽/短信彩信业务都已被屏蔽'));
	music_001_1_array.push(new cntCode('4/5','短信彩信业务都已被屏蔽/未发送任何业务'));
	music_001_1_array.push(new cntCode('4/6','短信彩信业务都已被屏蔽/短信业务已被发送'));
	music_001_1_array.push(new cntCode('4/7','短信彩信业务都已被屏蔽/彩信业务已被发送'));
	music_001_1_array.push(new cntCode('4/8','短信彩信业务都已被屏蔽/短信彩信业务都已被发送'));		
		
	music_001_1_array.push(new cntCode('5/1','未发送任何业务/未屏蔽任何业务'));
	music_001_1_array.push(new cntCode('5/2','未发送任何业务/短信业务已被屏蔽'));
	music_001_1_array.push(new cntCode('5/3','未发送任何业务/彩信业务已被屏蔽'));
	music_001_1_array.push(new cntCode('5/4','未发送任何业务/短信彩信业务都已被屏蔽'));
	music_001_1_array.push(new cntCode('5/5','未发送任何业务/未发送任何业务'));
	music_001_1_array.push(new cntCode('5/6','未发送任何业务/短信业务已被发送'));
	music_001_1_array.push(new cntCode('5/7','未发送任何业务/彩信业务已被发送'));
	music_001_1_array.push(new cntCode('5/8','未发送任何业务/短信彩信业务都已被发送'));	
	
	music_001_1_array.push(new cntCode('6/1','短信业务已被发送/未屏蔽任何业务'));
	music_001_1_array.push(new cntCode('6/2','短信业务已被发送/短信业务已被屏蔽'));
	music_001_1_array.push(new cntCode('6/3','短信业务已被发送/彩信业务已被屏蔽'));
	music_001_1_array.push(new cntCode('6/4','短信业务已被发送/短信彩信业务都已被屏蔽'));
	music_001_1_array.push(new cntCode('6/5','短信业务已被发送/未发送任何业务'));
	music_001_1_array.push(new cntCode('6/6','短信业务已被发送/短信业务已被发送'));
	music_001_1_array.push(new cntCode('6/7','短信业务已被发送/彩信业务已被发送'));
	music_001_1_array.push(new cntCode('6/8','短信业务已被发送/短信彩信业务都已被发送'));	
	
	music_001_1_array.push(new cntCode('7/1','彩信业务已被发送/未屏蔽任何业务'));
	music_001_1_array.push(new cntCode('7/2','彩信业务已被发送/短信业务已被屏蔽'));
	music_001_1_array.push(new cntCode('7/3','彩信业务已被发送/彩信业务已被屏蔽'));
	music_001_1_array.push(new cntCode('7/4','彩信业务已被发送/短信彩信业务都已被屏蔽'));
	music_001_1_array.push(new cntCode('7/5','彩信业务已被发送/未发送任何业务'));
	music_001_1_array.push(new cntCode('7/6','彩信业务已被发送/短信业务已被发送'));
	music_001_1_array.push(new cntCode('7/7','彩信业务已被发送/彩信业务已被发送'));
	music_001_1_array.push(new cntCode('7/8','彩信业务已被发送/短信彩信业务都已被发送'));	
	
	music_001_1_array.push(new cntCode('8/1','短信彩信业务都已被发送/未屏蔽任何业务'));
	music_001_1_array.push(new cntCode('8/2','短信彩信业务都已被发送/短信业务已被屏蔽'));
	music_001_1_array.push(new cntCode('8/3','短信彩信业务都已被发送/彩信业务已被屏蔽'));
	music_001_1_array.push(new cntCode('8/4','短信彩信业务都已被发送/短信彩信业务都已被屏蔽'));
	music_001_1_array.push(new cntCode('8/5','短信彩信业务都已被发送/未发送任何业务'));
	music_001_1_array.push(new cntCode('8/6','短信彩信业务都已被发送/短信业务已被发送'));
	music_001_1_array.push(new cntCode('8/7','短信彩信业务都已被发送/彩信业务已被发送'));
	music_001_1_array.push(new cntCode('8/8','短信彩信业务都已被发送/短信彩信业务都已被发送'));					
	
	}
	
	
	{
		var music_001_15_array=new Array();
		music_001_15_array.push(new cntCode('01','成功'));
		music_001_15_array.push(new cntCode('02','失败'));
	}
	
	
	//计费类型编码 music_002_1_array
	{
	var music_002_1_array=new Array();
	music_002_1_array.push(new cntCode('01','免费'));
	music_002_1_array.push(new cntCode('02','按次计费'));
	music_002_1_array.push(new cntCode('03','包月计费'));
	music_002_1_array.push(new cntCode('04','包月查询计费'));
	}
	//操作方式编码表 music_002_2_array
	{
	var music_002_2_array=new Array();
	music_002_2_array.push(new cntCode('001','WWW'));
	music_002_2_array.push(new cntCode('002','WAP'));
	music_002_2_array.push(new cntCode('003','IVR'));
	music_002_2_array.push(new cntCode('004','SMS'));
	music_002_2_array.push(new cntCode('005','USSD'));
	music_002_2_array.push(new cntCode('006','SMP'));
	music_002_2_array.push(new cntCode('007','平台客服'));
	music_002_2_array.push(new cntCode('008','SMAP'));
	music_002_2_array.push(new cntCode('009','BOSS'));
	music_002_2_array.push(new cntCode('010','网管'));
	music_002_2_array.push(new cntCode('011','按键复制'));
	music_002_2_array.push(new cntCode('012','语音搜索'));
	music_002_2_array.push(new cntCode('013','彩铃＋＋平台'));
	music_002_2_array.push(new cntCode('014','手机客户端'));
	music_002_2_array.push(new cntCode('015','综合即时通信（飞信）'));
	music_002_2_array.push(new cntCode('016','12580'));
	music_002_2_array.push(new cntCode('099','其它'));
	}
	//操作渠道编码表 music_002_3_array
	{
	var music_002_3_array=new Array();
	music_002_3_array.push(new cntCode('0011610','浙江凌科WEB10'));
	music_002_3_array.push(new cntCode('0011611','浙江凌科WEB11'));
	music_002_3_array.push(new cntCode('0011612','浙江凌科WEB1'));
	music_002_3_array.push(new cntCode('0011700','无线星空WEB'));
	music_002_3_array.push(new cntCode('0011701','无线星空WEB1'));
	music_002_3_array.push(new cntCode('0011702','无线星空WEB2'));
	music_002_3_array.push(new cntCode('0011703','无线星空WEB3'));
	music_002_3_array.push(new cntCode('0011704','无线星空WEB4'));
	music_002_3_array.push(new cntCode('0011705','无线星空WEB5'));
	music_002_3_array.push(new cntCode('0011706','无线星空WEB6'));
	music_002_3_array.push(new cntCode('0011707','无线星空WEB7'));
	music_002_3_array.push(new cntCode('0011708','无线星空WEB8'));
	music_002_3_array.push(new cntCode('0011709','无线星空WEB9'));
	music_002_3_array.push(new cntCode('0011710','无线星空WEB10'));
	music_002_3_array.push(new cntCode('0011711','无线星空WEB11'));
	music_002_3_array.push(new cntCode('0011712','无线星空WEB12'));
	music_002_3_array.push(new cntCode('0011713','无线星空WEB13'));
	music_002_3_array.push(new cntCode('0011714','无线星空WEB14'));
	music_002_3_array.push(new cntCode('0011715','无线星空WEB15'));
	music_002_3_array.push(new cntCode('0011716','无线星空WEB16'));
	music_002_3_array.push(new cntCode('0011717','无线星空WEB17'));
	music_002_3_array.push(new cntCode('0011718','无线星空WEB18'));
	music_002_3_array.push(new cntCode('0011719','无线星空WEB19'));
	music_002_3_array.push(new cntCode('0011720','无线星空WEB20'));
	music_002_3_array.push(new cntCode('0011721','无线星空WEB21'));
	music_002_3_array.push(new cntCode('0011722','无线星空WEB22'));
	music_002_3_array.push(new cntCode('0011723','无线星空WEB23'));
	music_002_3_array.push(new cntCode('0011724','无线星空WEB24'));
	music_002_3_array.push(new cntCode('0015000','腾讯WEB'));
	music_002_3_array.push(new cntCode('0015001','腾讯web1'));
	music_002_3_array.push(new cntCode('0015002','腾讯web2'));
	music_002_3_array.push(new cntCode('0015003','腾讯Web3'));
	music_002_3_array.push(new cntCode('0015100','搜狐WEB'));
	music_002_3_array.push(new cntCode('0015101','搜狐WEB1'));
	music_002_3_array.push(new cntCode('0015200','凤凰网WEB'));
	music_002_3_array.push(new cntCode('0015201','凤凰网WEB1'));
	music_002_3_array.push(new cntCode('0015202','凤凰网WEB2'));
	music_002_3_array.push(new cntCode('0015203','凤凰网WEB3'));
	music_002_3_array.push(new cntCode('0015204','凤凰网WEB4'));
	music_002_3_array.push(new cntCode('0015300','百度WEB'));
	music_002_3_array.push(new cntCode('0015301','百度WEB1'));
	music_002_3_array.push(new cntCode('0015302','百度WEB2'));
	music_002_3_array.push(new cntCode('0015303','百度WEB3'));
	music_002_3_array.push(new cntCode('0015304','百度WEB4'));
	music_002_3_array.push(new cntCode('0015305','百度WEB5'));
	music_002_3_array.push(new cntCode('0015400','Ucweb WEB'));
	music_002_3_array.push(new cntCode('0015401','Ucweb web 1'));
	music_002_3_array.push(new cntCode('0015500','坐标时代WEB'));
	music_002_3_array.push(new cntCode('0015501','坐标时代web1'));
	music_002_3_array.push(new cntCode('0015502','坐标时代web2'));
	music_002_3_array.push(new cntCode('0015503','坐标时代web3'));
	music_002_3_array.push(new cntCode('0015504','坐标时代web4'));
	music_002_3_array.push(new cntCode('0015600','广州正邦WEB'));
	music_002_3_array.push(new cntCode('0015601','广州正邦WEB21'));
	music_002_3_array.push(new cntCode('0015602','广州正邦WEB2'));
	music_002_3_array.push(new cntCode('0015603','广州正邦WEB3'));
	music_002_3_array.push(new cntCode('0015604','广州正邦WEB4'));
	music_002_3_array.push(new cntCode('0015605','广州正邦WEB5'));
	music_002_3_array.push(new cntCode('0015606','广州正邦WEB6'));
	music_002_3_array.push(new cntCode('0015607','广州正邦WEB7'));
	music_002_3_array.push(new cntCode('0015608','广州正邦WEB8'));
	music_002_3_array.push(new cntCode('0015609','广州正邦WEB9'));
	music_002_3_array.push(new cntCode('0015610','广州正邦WEB10'));
	music_002_3_array.push(new cntCode('0015611','广州正邦WEB11'));
	music_002_3_array.push(new cntCode('0015612','广州正邦WEB12'));
	music_002_3_array.push(new cntCode('0015613','广州正邦WEB13'));
	music_002_3_array.push(new cntCode('0015614','广州正邦WEB14'));
	music_002_3_array.push(new cntCode('0015615','广州正邦WEB15'));
	music_002_3_array.push(new cntCode('0015616','广州正邦WEB16'));
	music_002_3_array.push(new cntCode('0015617','广州正邦WEB17'));
	music_002_3_array.push(new cntCode('0015618','广州正邦WEB18'));
	music_002_3_array.push(new cntCode('0015619','广州正邦WEB19'));
	music_002_3_array.push(new cntCode('0015620','广州正邦WEB20'));
	music_002_3_array.push(new cntCode('0015621','广州正邦WEB21'));
	music_002_3_array.push(new cntCode('0016500','北纬点易WEB'));
	music_002_3_array.push(new cntCode('0016501','北纬点易WEB1'));
	music_002_3_array.push(new cntCode('0016510','北纬通信WEB'));
	music_002_3_array.push(new cntCode('0016511','北纬通信WEB1'));
	music_002_3_array.push(new cntCode('0016520','赛贝尔WEB'));
	music_002_3_array.push(new cntCode('0016530','酷6网WEB'));
	music_002_3_array.push(new cntCode('0016531','酷6网WEB1'));
	music_002_3_array.push(new cntCode('0016540','赛网WEB'));
	music_002_3_array.push(new cntCode('0016541','赛网WEB1'));
	music_002_3_array.push(new cntCode('0016550','杰伦中文网WEB'));
	music_002_3_array.push(new cntCode('0016551','杰伦中文网WEB1'));
	music_002_3_array.push(new cntCode('0016560','myspaceWEB'));
	music_002_3_array.push(new cntCode('0016561','myspaceWEB1'));
	music_002_3_array.push(new cntCode('0016570','网乐互联WEB'));
	music_002_3_array.push(new cntCode('0016571','网乐互联WEB1'));
	music_002_3_array.push(new cntCode('0016580','久游网WEB'));
	music_002_3_array.push(new cntCode('0016581','久游网WEB1'));
	music_002_3_array.push(new cntCode('0016590','爱唱久久WEB'));
	music_002_3_array.push(new cntCode('0016591','爱唱久久WEB1'));
	music_002_3_array.push(new cntCode('0016600','炫游在线WEB'));
	music_002_3_array.push(new cntCode('0016601','炫游在线web1'));
	music_002_3_array.push(new cntCode('0016610','广州圣元WEB'));
	music_002_3_array.push(new cntCode('0016611','广州圣元WEB1'));
	music_002_3_array.push(new cntCode('0016620','捉鱼网WEB'));
	music_002_3_array.push(new cntCode('0016621','捉鱼网WEB1'));
	music_002_3_array.push(new cntCode('0016630','皮皮网WEB'));
	music_002_3_array.push(new cntCode('0016631','皮皮网WEB1'));
	music_002_3_array.push(new cntCode('0016640','校内网WEB'));
	music_002_3_array.push(new cntCode('0016641','校内网WEB1'));
	music_002_3_array.push(new cntCode('0016650','PPSWEB'));
	music_002_3_array.push(new cntCode('0016651','PPS WEB1'));
	music_002_3_array.push(new cntCode('0016660','北京恒信WEB'));
	music_002_3_array.push(new cntCode('0016661','北京恒信WEB1'));
	music_002_3_array.push(new cntCode('0016670','乐乐星球WEB'));
	music_002_3_array.push(new cntCode('0016671','乐乐星球WEB1'));
	music_002_3_array.push(new cntCode('0016680','快播WEB'));
	music_002_3_array.push(new cntCode('0016681','快播WEB1'));
	music_002_3_array.push(new cntCode('0016690','空中网WEB'));
	music_002_3_array.push(new cntCode('0016700','1tingWEB'));
	music_002_3_array.push(new cntCode('0016701','1ting WEB1'));
	music_002_3_array.push(new cntCode('0016710','巨鲸WEB'));
	music_002_3_array.push(new cntCode('0016711','巨鲸WEB1'));
	music_002_3_array.push(new cntCode('0016720','创艺和弦WEB'));
	music_002_3_array.push(new cntCode('0016730','酷狗WEB'));
	music_002_3_array.push(new cntCode('0016731','酷狗WEB1'));
	music_002_3_array.push(new cntCode('0016740','yoboWEB'));
	music_002_3_array.push(new cntCode('0016741','yobo WEB1'));
	music_002_3_array.push(new cntCode('0016750','9533WEB'));
	music_002_3_array.push(new cntCode('0016751','9533 WEB1'));
	music_002_3_array.push(new cntCode('0016760','51网WEB'));
	music_002_3_array.push(new cntCode('0016761','51网WEB1'));
	music_002_3_array.push(new cntCode('0016770','中宽资讯WEB'));
	music_002_3_array.push(new cntCode('0016771','中宽资讯WEB1'));
	music_002_3_array.push(new cntCode('0016780','优酷WEB'));
	music_002_3_array.push(new cntCode('0016781','优酷WEB1'));
	music_002_3_array.push(new cntCode('0016790','大秦KTV联盟WEB'));
	music_002_3_array.push(new cntCode('0016791','大秦KTV联盟WEB1'));
	music_002_3_array.push(new cntCode('0016800','魔龙国际WEB'));
	music_002_3_array.push(new cntCode('0016801','魔龙国际WEB1'));
	music_002_3_array.push(new cntCode('0016810','朗博威WEB'));
	music_002_3_array.push(new cntCode('0016811','朗博威WEB1'));
	music_002_3_array.push(new cntCode('0016820','飞信WEB'));
	music_002_3_array.push(new cntCode('0016821','飞信WEB1'));
	music_002_3_array.push(new cntCode('0016830','顺网WEB'));
	music_002_3_array.push(new cntCode('0016831','顺网WEB1'));
	music_002_3_array.push(new cntCode('0016840','唯美空间WEB'));
	music_002_3_array.push(new cntCode('0016841','唯美空间WEB1'));
	music_002_3_array.push(new cntCode('0016850','大秦文化WEB'));
	music_002_3_array.push(new cntCode('0016851','大秦文化WEB1'));
	music_002_3_array.push(new cntCode('0016860','找乐吧WEB'));
	music_002_3_array.push(new cntCode('0016861','找乐吧WEB1'));
	music_002_3_array.push(new cntCode('0016870','青娱乐WEB'));
	music_002_3_array.push(new cntCode('0016871','青娱乐WEB1'));
	music_002_3_array.push(new cntCode('0016880','搜刮WEB'));
	music_002_3_array.push(new cntCode('0016881','搜刮WEB1'));
	music_002_3_array.push(new cntCode('0016890','北青网WEB'));
	music_002_3_array.push(new cntCode('0016891','北青网WEB1'));
	music_002_3_array.push(new cntCode('0016900','139社区WEB'));
	music_002_3_array.push(new cntCode('0016901','139社区WEB1'));
	music_002_3_array.push(new cntCode('0016910','天涯社区WEB'));
	music_002_3_array.push(new cntCode('0016911','天涯社区WEB1'));
	music_002_3_array.push(new cntCode('0016920','千龙网WEB'));
	music_002_3_array.push(new cntCode('0016921','千龙网WEB1'));
	music_002_3_array.push(new cntCode('0016930','龙腾阳光WEB'));
	music_002_3_array.push(new cntCode('0016931','龙腾阳光WEB1'));
	music_002_3_array.push(new cntCode('0016940','全天通WEB'));
	music_002_3_array.push(new cntCode('0016941','全天通WEB1'));
	music_002_3_array.push(new cntCode('0016951','无线星空WEB1'));
	music_002_3_array.push(new cntCode('0016960','北京泉彩WEB'));
	music_002_3_array.push(new cntCode('0016961','北京泉彩WEB1'));
	music_002_3_array.push(new cntCode('0016970','WIFUN无线乐园WEB'));
	music_002_3_array.push(new cntCode('0016971','WIFUN无线乐园WEB1'));
	music_002_3_array.push(new cntCode('0016980','美通WEB'));
	music_002_3_array.push(new cntCode('0016981','美通WEB1'));
	music_002_3_array.push(new cntCode('0016982','美通WEB2'));
	music_002_3_array.push(new cntCode('0016990','JUJUAOWEB'));
	music_002_3_array.push(new cntCode('0016991','JUJUMAO WEB1'));
	music_002_3_array.push(new cntCode('0017000','酷我WEB'));
	music_002_3_array.push(new cntCode('0017001','酷我WEB1'));
	music_002_3_array.push(new cntCode('0017010','易播WEB'));
	music_002_3_array.push(new cntCode('0017011','易播WEB1'));
	music_002_3_array.push(new cntCode('0017020','易播网WEB'));
	music_002_3_array.push(new cntCode('0017021','易播WEB1'));
	music_002_3_array.push(new cntCode('0017030','PPLIVEWEB'));
	music_002_3_array.push(new cntCode('0017031','PPLIVEWEB1'));
	music_002_3_array.push(new cntCode('0017040','赛迪网WEB'));
	music_002_3_array.push(new cntCode('0017041','赛迪网WEB1'));
	music_002_3_array.push(new cntCode('0017060','粉丝网WEB'));
	music_002_3_array.push(new cntCode('0017061','粉丝网WEB1'));
	music_002_3_array.push(new cntCode('0017070','深圳新飞WEB'));
	music_002_3_array.push(new cntCode('0017071','深圳新飞WEB1'));
	music_002_3_array.push(new cntCode('0017080','雷霆无极WEB'));
	music_002_3_array.push(new cntCode('0017081','雷霆无极WEB1'));
	music_002_3_array.push(new cntCode('0017090','灵讯互动WEB'));
	music_002_3_array.push(new cntCode('0017091','灵讯互动WEB1'));
	music_002_3_array.push(new cntCode('0017100','博客网WEB'));
	music_002_3_array.push(new cntCode('0017101','博客网WEB1'));
	music_002_3_array.push(new cntCode('0017102','博客网WEB2'));
	music_002_3_array.push(new cntCode('0017110','音乐八宝盒WEB'));
	music_002_3_array.push(new cntCode('0017111','音乐八宝盒WEB1'));
	music_002_3_array.push(new cntCode('0017120','佳友在线WEB'));
	music_002_3_array.push(new cntCode('0017121','佳友在线WEB1'));
	music_002_3_array.push(new cntCode('0017130','上海正东WEB'));
	music_002_3_array.push(new cntCode('0017131','上海正东WEB1'));
	music_002_3_array.push(new cntCode('0017140','泡泡网WEB'));
	music_002_3_array.push(new cntCode('0017141','泡泡网WEB1'));
	music_002_3_array.push(new cntCode('0017150','德州远帆WEB'));
	music_002_3_array.push(new cntCode('0017151','德州远帆WEB1'));
	music_002_3_array.push(new cntCode('0017160','好听WEB'));
	music_002_3_array.push(new cntCode('0017161','好听WEB1'));
	music_002_3_array.push(new cntCode('0017170','中国音乐在线WEB'));
	music_002_3_array.push(new cntCode('0017171','中国音乐在线WEB1'));
	music_002_3_array.push(new cntCode('0017180','九天音乐网WEB'));
	music_002_3_array.push(new cntCode('0017181','九天音乐网WEB1'));
	music_002_3_array.push(new cntCode('0017182','九天音乐网WEB2'));
	music_002_3_array.push(new cntCode('0017200','酷客音乐网WEB'));
	music_002_3_array.push(new cntCode('0017201','酷客音乐网WEB1'));
	music_002_3_array.push(new cntCode('0017210','分贝网WEB'));
	music_002_3_array.push(new cntCode('0017211','分贝网WEB1'));
	music_002_3_array.push(new cntCode('0017220','YYMP3WEB'));
	music_002_3_array.push(new cntCode('0017221','YYMP3 WEB1'));
	music_002_3_array.push(new cntCode('0017230','YY165WEB'));
	music_002_3_array.push(new cntCode('0017231','YY165WEB1'));
	music_002_3_array.push(new cntCode('0017240','华友世纪WEB'));
	music_002_3_array.push(new cntCode('0017241','华友世纪WEB1'));
	music_002_3_array.push(new cntCode('0017250','上海锐深51mikeWEB'));
	music_002_3_array.push(new cntCode('0017251','上海锐深51mike WEB1'));
	music_002_3_array.push(new cntCode('0017260','长江龙WEB'));
	music_002_3_array.push(new cntCode('0017261','长江龙WEB1'));
	music_002_3_array.push(new cntCode('0017270','巨明星飞WEB'));
	music_002_3_array.push(new cntCode('0017271','巨明星飞WEB1'));
	music_002_3_array.push(new cntCode('0017280','网尚文化WEB'));
	music_002_3_array.push(new cntCode('0017281','网尚文化WEB1'));
	music_002_3_array.push(new cntCode('0017290','种子音乐WEB'));
	music_002_3_array.push(new cntCode('0017291','种子音乐WEB1'));
	music_002_3_array.push(new cntCode('0017300','ktv'));
	music_002_3_array.push(new cntCode('0017301','星外星WEB1'));
	music_002_3_array.push(new cntCode('0017310','黑月文化WEB'));
	music_002_3_array.push(new cntCode('0017311','黑月文化WEB1'));
	music_002_3_array.push(new cntCode('0017320','光音盛世WEB'));
	music_002_3_array.push(new cntCode('0017321','光音盛世WEB1'));
	music_002_3_array.push(new cntCode('0017330','114啦WEB'));
	music_002_3_array.push(new cntCode('0017331','114啦WEB1'));
	music_002_3_array.push(new cntCode('0017332','114啦WEB2'));
	music_002_3_array.push(new cntCode('0017340','迷你站营销WEB'));
	music_002_3_array.push(new cntCode('0017341','迷你站营销WEB1'));
	music_002_3_array.push(new cntCode('0017350','恒天诚信WEB'));
	music_002_3_array.push(new cntCode('0017351','恒天诚信WEB1'));
	music_002_3_array.push(new cntCode('0017352','恒天诚信WEB2'));
	music_002_3_array.push(new cntCode('0017360','赛我网WEB'));
	music_002_3_array.push(new cntCode('0017361','赛我网WEB1'));
	music_002_3_array.push(new cntCode('0017370','滚石移动WEB'));
	music_002_3_array.push(new cntCode('0017371','滚石移动WEB1'));
	music_002_3_array.push(new cntCode('0017380','优歌WEB'));
	music_002_3_array.push(new cntCode('0017381','优歌WEB1'));
	music_002_3_array.push(new cntCode('0017390','网辉WEB'));
	music_002_3_array.push(new cntCode('0017391','网辉WEB1'));
	music_002_3_array.push(new cntCode('0017400','网兔网吧WEB'));
	music_002_3_array.push(new cntCode('0017401','网兔网吧WEB1'));
	music_002_3_array.push(new cntCode('0017410','视听天空WWW'));
	music_002_3_array.push(new cntCode('0017411','视听天空WEB1'));
	music_002_3_array.push(new cntCode('0017420','八乐音乐网WEB'));
	music_002_3_array.push(new cntCode('0017421','八乐音乐网WEB1'));
	music_002_3_array.push(new cntCode('0017430','56网WEB'));
	music_002_3_array.push(new cntCode('0017431','56网WEB1'));
	music_002_3_array.push(new cntCode('0017440','六间房WEB'));
	music_002_3_array.push(new cntCode('0017441','六间房WEB1'));
	music_002_3_array.push(new cntCode('0017450','久久娱乐WEB'));
	music_002_3_array.push(new cntCode('0017451','久久娱乐WEB1'));
	music_002_3_array.push(new cntCode('0017460','娱乐基地WEB'));
	music_002_3_array.push(new cntCode('0017461','娱乐基地WEB1'));
	music_002_3_array.push(new cntCode('0017470','暴风影音WEB'));
	music_002_3_array.push(new cntCode('0017471','暴风影音WEB1'));
	music_002_3_array.push(new cntCode('0017480','红莓果WEB'));
	music_002_3_array.push(new cntCode('0017481','红莓果WEB1'));
	music_002_3_array.push(new cntCode('0017490','上海赢思WEB'));
	music_002_3_array.push(new cntCode('0017491','上海赢思WEB1'));
	music_002_3_array.push(new cntCode('0017500','迅捷WEB'));
	music_002_3_array.push(new cntCode('0017501','迅捷WEB1'));
	music_002_3_array.push(new cntCode('0017510','河南卓睿'));
	music_002_3_array.push(new cntCode('0017511','河南卓睿WEB1'));
	music_002_3_array.push(new cntCode('0017512','河南卓睿WEB2'));
	music_002_3_array.push(new cntCode('0017513','河南卓睿WEB3'));
	music_002_3_array.push(new cntCode('0017514','河南卓睿WEB4'));
	music_002_3_array.push(new cntCode('0017515','河南卓睿WEB5'));
	music_002_3_array.push(new cntCode('0017520','北京群立WEB'));
	music_002_3_array.push(new cntCode('0017521','北京群立WEB1'));
	music_002_3_array.push(new cntCode('0019600','google WEB'));
	music_002_3_array.push(new cntCode('0019601','google WEB1'));
	music_002_3_array.push(new cntCode('0019610','雅虎WEB'));
	music_002_3_array.push(new cntCode('0019611','雅虎WEB1'));
	music_002_3_array.push(new cntCode('0019612','雅虎web2'));
	music_002_3_array.push(new cntCode('0019620','网易WEB'));
	music_002_3_array.push(new cntCode('0019621','网易WEB1'));
	music_002_3_array.push(new cntCode('0019630','TOM WEB'));
	music_002_3_array.push(new cntCode('0019631','TOM WEB1'));
	music_002_3_array.push(new cntCode('0019640','动感地带WEB'));
	music_002_3_array.push(new cntCode('0019641','动感地带WEB1'));
	music_002_3_array.push(new cntCode('0019650','MSN WEB'));
	music_002_3_array.push(new cntCode('0019651','MSN WEB1'));
	music_002_3_array.push(new cntCode('0019660','维畅基石WEB'));
	music_002_3_array.push(new cntCode('0019661','维畅基石WEB1'));
	music_002_3_array.push(new cntCode('0019670','移动分公司WEB'));
	music_002_3_array.push(new cntCode('0019671','移动分公司WEB1'));
	music_002_3_array.push(new cntCode('0019672','移动分公司WEB2'));
	music_002_3_array.push(new cntCode('0019680','乐林文化WEB'));
	music_002_3_array.push(new cntCode('0019681','乐林文化WEB1'));
	music_002_3_array.push(new cntCode('0019690','欣瑞拓成WEB'));
	music_002_3_array.push(new cntCode('0019691','欣瑞拓成WEB1'));
	music_002_3_array.push(new cntCode('0019700','华友飞乐WEB'));
	music_002_3_array.push(new cntCode('0019701','华友飞乐WEB1'));
	music_002_3_array.push(new cntCode('0019710','宇悦无限网站WEB'));
	music_002_3_array.push(new cntCode('0019711','宇悦无限网站(思特奇)WEB1'));
	music_002_3_array.push(new cntCode('0019720','滚石WEB'));
	music_002_3_array.push(new cntCode('0019721','滚石WEB1'));
	music_002_3_array.push(new cntCode('0019730','街舞大赛WEB'));
	music_002_3_array.push(new cntCode('0019731','街舞大赛WEB1'));
	music_002_3_array.push(new cntCode('0019740','土豆网WEB'));
	music_002_3_array.push(new cntCode('0019741','土豆网WEB1'));
	music_002_3_array.push(new cntCode('0019750','太和麦田WEB'));
	music_002_3_array.push(new cntCode('0019751','太和麦田WEB1'));
	music_002_3_array.push(new cntCode('0019760','ylmf广告WEB'));
	music_002_3_array.push(new cntCode('0019761','ylmf广告WEB1'));
	music_002_3_array.push(new cntCode('0019770','MDA WEB'));
	music_002_3_array.push(new cntCode('0019771','MDA WEB1'));
	music_002_3_array.push(new cntCode('0019780','bolanderWEB'));
	music_002_3_array.push(new cntCode('0019781','bolanderWEB1'));
	music_002_3_array.push(new cntCode('0019790','烁声传媒WEB'));
	music_002_3_array.push(new cntCode('0019791','烁声传媒WEB1'));
	music_002_3_array.push(new cntCode('0019800','赛尔网WEB'));
	music_002_3_array.push(new cntCode('0019801','赛尔网WEB1'));
	music_002_3_array.push(new cntCode('0019810','相信音乐WEB'));
	music_002_3_array.push(new cntCode('0019811','相信音乐WEB1'));
	music_002_3_array.push(new cntCode('0019820','3GV8(三代动力)WEB'));
	music_002_3_array.push(new cntCode('0019821','3GV8(三代动力)WEB1'));
	music_002_3_array.push(new cntCode('0019830','A8WEB'));
	music_002_3_array.push(new cntCode('0019831','A8WEB1'));
	music_002_3_array.push(new cntCode('0019840','千橡集团(校内网)WEB'));
	music_002_3_array.push(new cntCode('0019841','千橡集团(校内网)WEB1'));
	music_002_3_array.push(new cntCode('0020005','四川思特奇'));
	music_002_3_array.push(new cntCode('0021000','臻网WAP'));
	music_002_3_array.push(new cntCode('0021001','臻网WAP1'));
	music_002_3_array.push(new cntCode('0021002','臻网WAP2'));
	music_002_3_array.push(new cntCode('0021003','臻网WAP3'));
	music_002_3_array.push(new cntCode('0021004','臻网WAP4'));
	music_002_3_array.push(new cntCode('0021005','臻网WAP5'));
	music_002_3_array.push(new cntCode('0021006','臻网WAP6'));
	music_002_3_array.push(new cntCode('0021007','臻网WAP7'));
	music_002_3_array.push(new cntCode('0021010','12530WAP'));
	music_002_3_array.push(new cntCode('0021052','12530手机下载'));
	music_002_3_array.push(new cntCode('0021100','万讯通WAP'));
	music_002_3_array.push(new cntCode('0021101','全曲平台'));
	music_002_3_array.push(new cntCode('0021102','万讯通WAP2'));
	music_002_3_array.push(new cntCode('0021103','万讯通WAP3'));
	music_002_3_array.push(new cntCode('0021104','万讯通WAP4'));
	music_002_3_array.push(new cntCode('0021105','万讯通WAP5'));
	music_002_3_array.push(new cntCode('0021106','万讯通WAP6'));
	music_002_3_array.push(new cntCode('0021107','万讯通WAP7'));
	music_002_3_array.push(new cntCode('0021108','万讯通WAP8'));
	music_002_3_array.push(new cntCode('0021109','万讯通WAP9'));
	music_002_3_array.push(new cntCode('0021200','浙江凌科WAP'));
	music_002_3_array.push(new cntCode('0021201','浙江凌科WAP1'));
	music_002_3_array.push(new cntCode('0021202','浙江凌科WAP3'));
	music_002_3_array.push(new cntCode('0021203','浙江凌科WAP2'));
	music_002_3_array.push(new cntCode('0021204','浙江凌科WAP4'));
	music_002_3_array.push(new cntCode('0021205','浙江凌科WAP5'));
	music_002_3_array.push(new cntCode('0021206','浙江凌科WAP6'));
	music_002_3_array.push(new cntCode('0021207','浙江凌科WAP7'));
	music_002_3_array.push(new cntCode('0021208','浙江凌科WAP8'));
	music_002_3_array.push(new cntCode('0021209','浙江凌科WAP9'));
	music_002_3_array.push(new cntCode('0021210','浙江凌科WAP10'));
	music_002_3_array.push(new cntCode('0021211','浙江凌科WAP11'));
	music_002_3_array.push(new cntCode('0021212','浙江凌科WAP12'));
	music_002_3_array.push(new cntCode('0021213','浙江凌科WAP13'));
	music_002_3_array.push(new cntCode('0021300','亿动传媒WAP'));
	music_002_3_array.push(new cntCode('0021301','亿动传媒WAP1'));
	music_002_3_array.push(new cntCode('0021302','亿动传媒WAP3'));
	music_002_3_array.push(new cntCode('0021303','亿动传媒WAP4'));
	music_002_3_array.push(new cntCode('0021304','亿动传媒WAP5'));
	music_002_3_array.push(new cntCode('0021305','亿动传媒WAP6'));
	music_002_3_array.push(new cntCode('0021306','亿动传媒WAP7'));
	music_002_3_array.push(new cntCode('0021307','亿动传媒WAP8'));
	music_002_3_array.push(new cntCode('0021308','亿动传媒WAP9'));
	music_002_3_array.push(new cntCode('0021309','亿动传媒WAP10'));
	music_002_3_array.push(new cntCode('0021310','亿动传媒WAP11'));
	music_002_3_array.push(new cntCode('0021311','亿动传媒WAP12'));
	music_002_3_array.push(new cntCode('0021312','亿动传媒WAP13'));
	music_002_3_array.push(new cntCode('0021313','亿动传媒WAP14'));
	music_002_3_array.push(new cntCode('0021314','亿动传媒WAP15'));
	music_002_3_array.push(new cntCode('0021315','亿动传媒WAP16'));
	music_002_3_array.push(new cntCode('0021316','亿动传媒WAP17'));
	music_002_3_array.push(new cntCode('0021317','亿动传媒WAP2'));
	music_002_3_array.push(new cntCode('0021318','亿动传媒WAP18'));
	music_002_3_array.push(new cntCode('0021319','亿动传媒WAP19'));
	music_002_3_array.push(new cntCode('0021320','亿动传媒WAP20'));
	music_002_3_array.push(new cntCode('0021400','杭州欧鹏WAP'));
	music_002_3_array.push(new cntCode('0021401','杭州欧鹏WAP1'));
	music_002_3_array.push(new cntCode('0021402','杭州欧鹏WAP2'));
	music_002_3_array.push(new cntCode('0021403','杭州欧鹏WAP3'));
	music_002_3_array.push(new cntCode('0021404','杭州欧鹏WAP4'));
	music_002_3_array.push(new cntCode('0021405','杭州欧鹏WAP5'));
	music_002_3_array.push(new cntCode('0021406','杭州欧鹏WAP6'));
	music_002_3_array.push(new cntCode('0021407','杭州欧鹏WAP7'));
	music_002_3_array.push(new cntCode('0021408','杭州欧鹏WAP8'));
	music_002_3_array.push(new cntCode('0021409','杭州欧鹏WAP9'));
	music_002_3_array.push(new cntCode('0021500','酷碟WAP'));
	music_002_3_array.push(new cntCode('0021501','酷碟WAP1'));
	music_002_3_array.push(new cntCode('0021502','酷碟WAP2'));
	music_002_3_array.push(new cntCode('0021503','酷碟WAP3'));
	music_002_3_array.push(new cntCode('0021504','酷碟WAP4'));
	music_002_3_array.push(new cntCode('0021505','酷碟WAP5'));
	music_002_3_array.push(new cntCode('0021506','酷碟WAP6'));
	music_002_3_array.push(new cntCode('0021507','酷碟WAP7'));
	music_002_3_array.push(new cntCode('0021508','酷碟WAP8'));
	music_002_3_array.push(new cntCode('0021509','酷碟WAP9'));
	music_002_3_array.push(new cntCode('0021510','酷碟WAP10'));
	music_002_3_array.push(new cntCode('0021511','酷碟WAP11'));
	music_002_3_array.push(new cntCode('0021512','酷碟WAP12'));
	music_002_3_array.push(new cntCode('0021513','酷碟彩铃营销'));
	music_002_3_array.push(new cntCode('0021514','酷碟振铃营销'));
	music_002_3_array.push(new cntCode('0021600','盛世新普(WAP世纪)'));
	music_002_3_array.push(new cntCode('0021601','wap世纪WAP1'));
	music_002_3_array.push(new cntCode('0021602','wap世纪WAP2'));
	music_002_3_array.push(new cntCode('0021603','wap世纪WAP3'));
	music_002_3_array.push(new cntCode('0021604','wap世纪WAP4'));
	music_002_3_array.push(new cntCode('0021605','wap世纪WAP5'));
	music_002_3_array.push(new cntCode('0021606','wap世纪WAP6'));
	music_002_3_array.push(new cntCode('0021607','wap世纪WAP7'));
	music_002_3_array.push(new cntCode('0021608','wap世纪WAP8'));
	music_002_3_array.push(new cntCode('0021609','wap世纪WAP9'));
	music_002_3_array.push(new cntCode('0021610','wap世纪WAP10'));
	music_002_3_array.push(new cntCode('0021611','wap世纪WAP11'));
	music_002_3_array.push(new cntCode('0021700','偶偶WAP'));
	music_002_3_array.push(new cntCode('0021701','偶偶WAP1'));
	music_002_3_array.push(new cntCode('0021702','偶偶WAP2'));
	music_002_3_array.push(new cntCode('0021703','偶偶WAP3'));
	music_002_3_array.push(new cntCode('0021704','偶偶WAP4'));
	music_002_3_array.push(new cntCode('0021705','偶偶WAP5'));
	music_002_3_array.push(new cntCode('0021706','偶偶WAP6'));
	music_002_3_array.push(new cntCode('0021707','偶偶WAP7'));
	music_002_3_array.push(new cntCode('0021708','偶偶WAP8'));
	music_002_3_array.push(new cntCode('0021709','偶偶WAP9'));
	music_002_3_array.push(new cntCode('0021710','偶偶WAP10'));
	music_002_3_array.push(new cntCode('0021800','广州久邦WAP'));
	music_002_3_array.push(new cntCode('0021801','广州久邦WAP1'));
	music_002_3_array.push(new cntCode('0021802','广州久邦WAP2'));
	music_002_3_array.push(new cntCode('0021803','广州久邦WAP3'));
	music_002_3_array.push(new cntCode('0021804','广州久邦WAP4'));
	music_002_3_array.push(new cntCode('0021805','广州久邦WAP5'));
	music_002_3_array.push(new cntCode('0021806','广州久邦WAP6'));
	music_002_3_array.push(new cntCode('0021807','广州久邦WAP7'));
	music_002_3_array.push(new cntCode('0021808','广州久邦WAP8'));
	music_002_3_array.push(new cntCode('0021809','广州久邦WAP9'));
	music_002_3_array.push(new cntCode('0021900','杭州斯凯WAP'));
	music_002_3_array.push(new cntCode('0021901','杭州斯凯WAP1'));
	music_002_3_array.push(new cntCode('0021902','杭州斯凯WAP2'));
	music_002_3_array.push(new cntCode('0021903','杭州斯凯WAP3'));
	music_002_3_array.push(new cntCode('0021904','杭州斯凯WAP4'));
	music_002_3_array.push(new cntCode('0021905','杭州斯凯WAP5'));
	music_002_3_array.push(new cntCode('0021906','杭州斯凯WAP6'));
	music_002_3_array.push(new cntCode('0021907','杭州斯凯WAP7'));
	music_002_3_array.push(new cntCode('0021908','杭州斯凯WAP8'));
	music_002_3_array.push(new cntCode('0021909','杭州斯凯WAP9'));
	music_002_3_array.push(new cntCode('0021910','杭州斯凯WAP10'));
	music_002_3_array.push(new cntCode('0022000','空中网新WAP'));
	music_002_3_array.push(new cntCode('0022001','空中网新wap2'));
	music_002_3_array.push(new cntCode('0022002','空中网新wap3'));
	music_002_3_array.push(new cntCode('0022003','空中网新wap4'));
	music_002_3_array.push(new cntCode('0022004','空中网新wap5'));
	music_002_3_array.push(new cntCode('0022005','空中网新wap6'));
	music_002_3_array.push(new cntCode('0022006','空中网新wap7'));
	music_002_3_array.push(new cntCode('0022007','空中网新wap8'));
	music_002_3_array.push(new cntCode('0022008','空中网新wap9'));
	music_002_3_array.push(new cntCode('0022009','空中网新wap10'));
	music_002_3_array.push(new cntCode('0022010','空中网新wap11'));
	music_002_3_array.push(new cntCode('0025000','百度WAP'));
	music_002_3_array.push(new cntCode('0025001','百度WAP1'));
	music_002_3_array.push(new cntCode('0025002','百度WAP2'));
	music_002_3_array.push(new cntCode('0025003','百度WAP3'));
	music_002_3_array.push(new cntCode('0025004','百度WAP4'));
	music_002_3_array.push(new cntCode('0025100','腾讯WAP'));
	music_002_3_array.push(new cntCode('0025101','腾讯WAP1'));
	music_002_3_array.push(new cntCode('0025102','腾讯WAP2'));
	music_002_3_array.push(new cntCode('0025103','腾讯WAP3'));
	music_002_3_array.push(new cntCode('0025104','腾讯WAP4'));
	music_002_3_array.push(new cntCode('0025200','搜狐WAP'));
	music_002_3_array.push(new cntCode('0025201','搜狐WAP1'));
	music_002_3_array.push(new cntCode('0025202','搜狐WAP2'));
	music_002_3_array.push(new cntCode('0025203','搜狐WAP3'));
	music_002_3_array.push(new cntCode('0025204','搜狐WAP4'));
	music_002_3_array.push(new cntCode('0025205','搜狐WAP6'));
	music_002_3_array.push(new cntCode('0025300','凤凰网WAP'));
	music_002_3_array.push(new cntCode('0025301','凤凰网WAP1'));
	music_002_3_array.push(new cntCode('0025302','凤凰网WAP2'));
	music_002_3_array.push(new cntCode('0025303','凤凰网WAP3'));
	music_002_3_array.push(new cntCode('0025304','凤凰网WAP4'));
	music_002_3_array.push(new cntCode('0025400','Ucweb WAP'));
	music_002_3_array.push(new cntCode('0025401','Ucweb wap 1'));
	music_002_3_array.push(new cntCode('0025402','Ucweb wap 2'));
	music_002_3_array.push(new cntCode('0025403','Ucweb wap 3'));
	music_002_3_array.push(new cntCode('0025404','Ucweb wap 4'));
	music_002_3_array.push(new cntCode('0025405','Ucweb wap 5'));
	music_002_3_array.push(new cntCode('0025406','Ucweb wap 6'));
	music_002_3_array.push(new cntCode('0025407','Ucweb wap 7'));
	music_002_3_array.push(new cntCode('0025408','Ucweb wap 8'));
	music_002_3_array.push(new cntCode('0025409','Ucweb wap 9'));
	music_002_3_array.push(new cntCode('0025410','Ucweb wap 10'));
	music_002_3_array.push(new cntCode('0025411','Ucweb wap 11'));
	music_002_3_array.push(new cntCode('0025412','Ucweb wap 12'));
	music_002_3_array.push(new cntCode('0025413','Ucweb wap 13'));
	music_002_3_array.push(new cntCode('0025414','Ucweb wap 14'));
	music_002_3_array.push(new cntCode('0025415','Ucweb wap 15'));
	music_002_3_array.push(new cntCode('0025416','Ucweb wap 16'));
	music_002_3_array.push(new cntCode('0025417','Ucweb wap 17'));
	music_002_3_array.push(new cntCode('0025418','Ucweb wap 18'));
	music_002_3_array.push(new cntCode('0025419','Ucweb wap 19'));
	music_002_3_array.push(new cntCode('0025420','Ucweb wap 20'));
	music_002_3_array.push(new cntCode('0025421','Ucweb wap 21'));
	music_002_3_array.push(new cntCode('0025422','Ucweb wap 22'));
	music_002_3_array.push(new cntCode('0025500','坐标时代WAP'));
	music_002_3_array.push(new cntCode('0025501','坐标时代wap1'));
	music_002_3_array.push(new cntCode('0025502','坐标时代wap2'));
	music_002_3_array.push(new cntCode('0025503','坐标时代WAP3'));
	music_002_3_array.push(new cntCode('0025504','坐标时代WAP4'));
	music_002_3_array.push(new cntCode('0025505','坐标时代WAP5'));
	music_002_3_array.push(new cntCode('0025600','爱可信WAP'));
	music_002_3_array.push(new cntCode('0025601','爱可信WAP1'));
	music_002_3_array.push(new cntCode('0025602','爱可信WAP2'));
	music_002_3_array.push(new cntCode('0025603','爱可信WAP3'));
	music_002_3_array.push(new cntCode('0025604','爱可信WAP4'));
	music_002_3_array.push(new cntCode('0025605','爱可信WAP5'));
	music_002_3_array.push(new cntCode('0026500','北纬通信WAP'));
	music_002_3_array.push(new cntCode('0026501','北纬通信WAP1'));
	music_002_3_array.push(new cntCode('0026502','北纬通信WAP2'));
	music_002_3_array.push(new cntCode('0026510','赛贝尔WAP'));
	music_002_3_array.push(new cntCode('0026511','赛贝尔WAP1'));
	music_002_3_array.push(new cntCode('0026520','杰伦中文网WAP'));
	music_002_3_array.push(new cntCode('0026521','杰伦中文网WAP1'));
	music_002_3_array.push(new cntCode('0026530','爱唱久久WAP'));
	music_002_3_array.push(new cntCode('0026531','爱唱久久WAP1'));
	music_002_3_array.push(new cntCode('0026532','爱唱久久WAP2'));
	music_002_3_array.push(new cntCode('0026540','炫游在线WAP'));
	music_002_3_array.push(new cntCode('0026541','炫游在线WAP1'));
	music_002_3_array.push(new cntCode('0026542','炫游在线WAP2'));
	music_002_3_array.push(new cntCode('0026543','炫游在线WAP3'));
	music_002_3_array.push(new cntCode('0026544','炫游在线WAP4'));
	music_002_3_array.push(new cntCode('0026550','捉鱼网WAP'));
	music_002_3_array.push(new cntCode('0026551','捉鱼网WAP1'));
	music_002_3_array.push(new cntCode('0026552','捉鱼网WAP2'));
	music_002_3_array.push(new cntCode('0026560','宜搜WAP'));
	music_002_3_array.push(new cntCode('0026561','宜搜WAP1'));
	music_002_3_array.push(new cntCode('0026562','宜搜WAP2'));
	music_002_3_array.push(new cntCode('0026563','宜搜WAP3'));
	music_002_3_array.push(new cntCode('0026564','宜搜WAP4'));
	music_002_3_array.push(new cntCode('0026565','宜搜WAP5'));
	music_002_3_array.push(new cntCode('0026570','校内网WAP'));
	music_002_3_array.push(new cntCode('0026571','校内网WAP1'));
	music_002_3_array.push(new cntCode('0026580','千尺无限WAP'));
	music_002_3_array.push(new cntCode('0026581','千尺无限WAP1'));
	music_002_3_array.push(new cntCode('0026590','深圳凯旋WAP'));
	music_002_3_array.push(new cntCode('0026591','深圳凯旋WAP1'));
	music_002_3_array.push(new cntCode('0026592','深圳凯旋WAP2'));
	music_002_3_array.push(new cntCode('0026593','深圳凯旋WAP3'));
	music_002_3_array.push(new cntCode('0026594','深圳凯旋WAP4'));
	music_002_3_array.push(new cntCode('0026600','天天动听WAP'));
	music_002_3_array.push(new cntCode('0026601','结信'));
	music_002_3_array.push(new cntCode('0026602','天天动听WAP1'));
	music_002_3_array.push(new cntCode('0026610','易天新动WAP'));
	music_002_3_array.push(new cntCode('0026611','易天新动WAP1'));
	music_002_3_array.push(new cntCode('0026614','华友世纪精品业务'));
	music_002_3_array.push(new cntCode('0026615','TOM精品业务'));
	music_002_3_array.push(new cntCode('0026616','空中网精品业务'));
	music_002_3_array.push(new cntCode('0026620','青娱乐WAP'));
	music_002_3_array.push(new cntCode('0026621','青娱乐WAP1'));
	music_002_3_array.push(new cntCode('0026622','青娱乐WAP2'));
	music_002_3_array.push(new cntCode('0026630','空中网WAP'));
	music_002_3_array.push(new cntCode('0026631','空中网WAP1'));
	music_002_3_array.push(new cntCode('0026640','1tingWAP'));
	music_002_3_array.push(new cntCode('0026641','1ting WAP1'));
	music_002_3_array.push(new cntCode('0026650','巨鲸WAP'));
	music_002_3_array.push(new cntCode('0026651','巨鲸WAP1'));
	music_002_3_array.push(new cntCode('0026660','创艺和弦WAP'));
	music_002_3_array.push(new cntCode('0026661','创艺和弦WAP1'));
	music_002_3_array.push(new cntCode('0026662','创艺和弦WAP2'));
	music_002_3_array.push(new cntCode('0026670','酷狗WAP'));
	music_002_3_array.push(new cntCode('0026671','酷狗WAP1'));
	music_002_3_array.push(new cntCode('0026672','酷狗WAP2'));
	music_002_3_array.push(new cntCode('0026673','酷狗WAP3'));
	music_002_3_array.push(new cntCode('0026674','酷狗WAP4'));
	music_002_3_array.push(new cntCode('0026675','酷狗WAP5'));
	music_002_3_array.push(new cntCode('0026676','酷狗WAP6'));
	music_002_3_array.push(new cntCode('0026677','酷狗WAP7'));
	music_002_3_array.push(new cntCode('0026678','酷狗WAP8'));
	music_002_3_array.push(new cntCode('0026680','9533WAP'));
	music_002_3_array.push(new cntCode('0026681','9533 WAP1'));
	music_002_3_array.push(new cntCode('0026690','51网WAP'));
	music_002_3_array.push(new cntCode('0026691','51网WAP1'));
	music_002_3_array.push(new cntCode('0026692','51网WAP2'));
	music_002_3_array.push(new cntCode('0026700','中宽资讯WAP'));
	music_002_3_array.push(new cntCode('0026701','中宽资讯WAP1'));
	music_002_3_array.push(new cntCode('0026702','中宽WAP2'));
	music_002_3_array.push(new cntCode('0026703','中宽WAP3'));
	music_002_3_array.push(new cntCode('0026710','优酷WAP'));
	music_002_3_array.push(new cntCode('0026711','优酷WAP1'));
	music_002_3_array.push(new cntCode('0026720','魔龙国际WAP'));
	music_002_3_array.push(new cntCode('0026721','魔龙国际WAP1'));
	music_002_3_array.push(new cntCode('0026730','飞信WAP'));
	music_002_3_array.push(new cntCode('0026731','飞信WAP1'));
	music_002_3_array.push(new cntCode('0026740','EMIWAP'));
	music_002_3_array.push(new cntCode('0026741','EMI WAP1'));
	music_002_3_array.push(new cntCode('0026750','迅捷WAP'));
	music_002_3_array.push(new cntCode('0026751','迅捷 WAP1'));
	music_002_3_array.push(new cntCode('0026760','美通WAP'));
	music_002_3_array.push(new cntCode('0026761','美通WAP1'));
	music_002_3_array.push(new cntCode('0026762','美通WAP2'));
	music_002_3_array.push(new cntCode('0026763','美通WAP3'));
	music_002_3_array.push(new cntCode('0026764','美通WAP4'));
	music_002_3_array.push(new cntCode('0026770','JUJUMAOWAP'));
	music_002_3_array.push(new cntCode('0026771','JUJUMAO WAP1'));
	music_002_3_array.push(new cntCode('0026780','酷我WAP'));
	music_002_3_array.push(new cntCode('0026781','酷我WAP1'));
	music_002_3_array.push(new cntCode('0026800','德州远帆WAP'));
	music_002_3_array.push(new cntCode('0026801','德州远帆WAP1'));
	music_002_3_array.push(new cntCode('0026810','好听WAP'));
	music_002_3_array.push(new cntCode('0026811','好听WAP1'));
	music_002_3_array.push(new cntCode('0026812','好听WAP2'));
	music_002_3_array.push(new cntCode('0026820','YYMP3WAP'));
	music_002_3_array.push(new cntCode('0026821','YYMP3 WAP1'));
	music_002_3_array.push(new cntCode('0026830','种子音乐WAP'));
	music_002_3_array.push(new cntCode('0026831','种子音乐WAP1'));
	music_002_3_array.push(new cntCode('0026840','114啦WAP'));
	music_002_3_array.push(new cntCode('0026841','114啦WAP1'));
	music_002_3_array.push(new cntCode('0026850','富年电子WAP'));
	music_002_3_array.push(new cntCode('0026851','富年电子WAP1'));
	music_002_3_array.push(new cntCode('0026852','富年电子WAP2'));
	music_002_3_array.push(new cntCode('0026853','富年电子WAP3'));
	music_002_3_array.push(new cntCode('0026854','富年电子WAP4'));
	music_002_3_array.push(new cntCode('0026860','易查WAP'));
	music_002_3_array.push(new cntCode('0026861','易查WAP1'));
	music_002_3_array.push(new cntCode('0026870','易捷凌科WAP'));
	music_002_3_array.push(new cntCode('0026871','易捷凌科WAP1'));
	music_002_3_array.push(new cntCode('0026872','易捷凌科WAP2'));
	music_002_3_array.push(new cntCode('0026880','环球WAP'));
	music_002_3_array.push(new cntCode('0026881','环球WAP1'));
	music_002_3_array.push(new cntCode('0026882','环球WAP2'));
	music_002_3_array.push(new cntCode('0026890','SONYBMGWAP'));
	music_002_3_array.push(new cntCode('0026891','SONYBMG WAP1'));
	music_002_3_array.push(new cntCode('0026900','老孙文化WAP'));
	music_002_3_array.push(new cntCode('0026901','老孙文化WAP1'));
	music_002_3_array.push(new cntCode('0026910','海蝶WAP'));
	music_002_3_array.push(new cntCode('0026911','海蝶WAP1'));
	music_002_3_array.push(new cntCode('0026920','九天音乐网WAP'));
	music_002_3_array.push(new cntCode('0026921','九天音乐网WAP1'));
	music_002_3_array.push(new cntCode('0026922','九天音乐网WAP2'));
	music_002_3_array.push(new cntCode('0026923','九天音乐网WAP3'));
	music_002_3_array.push(new cntCode('0026930','悟空搜索WAP'));
	music_002_3_array.push(new cntCode('0026931','悟空搜索WAP1'));
	music_002_3_array.push(new cntCode('0026932','悟空搜索WAP2'));
	music_002_3_array.push(new cntCode('0026940','滚石移动WAP'));
	music_002_3_array.push(new cntCode('0026941','滚石移动WAP1'));
	music_002_3_array.push(new cntCode('0026942','滚石移动WAP2'));
	music_002_3_array.push(new cntCode('0026943','滚石移动WAP3'));
	music_002_3_array.push(new cntCode('0026944','滚石移动WAP4'));
	music_002_3_array.push(new cntCode('0026945','滚石移动WAP5'));
	music_002_3_array.push(new cntCode('0026946','滚石移动WAP6'));
	music_002_3_array.push(new cntCode('0026947','滚石移动WAP7'));
	music_002_3_array.push(new cntCode('0026948','滚石移动WAP8'));
	music_002_3_array.push(new cntCode('0026949','滚石移动WAP9'));
	music_002_3_array.push(new cntCode('0026950','蜂蜜网WAP'));
	music_002_3_array.push(new cntCode('0026951','蜂蜜网WAP1'));
	music_002_3_array.push(new cntCode('0026952','蜂蜜网WAP2'));
	music_002_3_array.push(new cntCode('0026960','赛网WAP'));
	music_002_3_array.push(new cntCode('0026961','赛网WAP1'));
	music_002_3_array.push(new cntCode('0026970','百亚WAP'));
	music_002_3_array.push(new cntCode('0026971','百亚WAP1'));
	music_002_3_array.push(new cntCode('0026972','百亚WAP2'));
	music_002_3_array.push(new cntCode('0026973','百亚WAP3'));
	music_002_3_array.push(new cntCode('0026974','百亚WAP4'));
	music_002_3_array.push(new cntCode('0026975','百亚WAP5'));
	music_002_3_array.push(new cntCode('0026980','深圳东润WAP'));
	music_002_3_array.push(new cntCode('0026981','深圳东润（易蛙传媒）WAP1'));
	music_002_3_array.push(new cntCode('0026990','艾逥WAP'));
	music_002_3_array.push(new cntCode('0026991','艾逥WAP1'));
	music_002_3_array.push(new cntCode('0027000','亚神WAP'));
	music_002_3_array.push(new cntCode('0027001','亚神WAP1'));
	music_002_3_array.push(new cntCode('0027010','北京群立WAP'));
	music_002_3_array.push(new cntCode('0027011','北京群立WAP1'));
	music_002_3_array.push(new cntCode('0027020','天天动听WAP'));
	music_002_3_array.push(new cntCode('0027021','天天动听WAP1'));
	music_002_3_array.push(new cntCode('0027030','百度手机在线WAP'));
	music_002_3_array.push(new cntCode('0027031','百度手机在线WAP1'));
	music_002_3_array.push(new cntCode('0027032','百度手机在线WAP2'));
	music_002_3_array.push(new cntCode('0027033','百度手机在线WAP3'));
	music_002_3_array.push(new cntCode('0027034','百度手机在线WAP4'));
	music_002_3_array.push(new cntCode('0027035','百度手机在线WAP5'));
	music_002_3_array.push(new cntCode('0027036','百度手机在线WAP6'));
	music_002_3_array.push(new cntCode('0027040','河南卓睿WAP'));
	music_002_3_array.push(new cntCode('0027041','河南卓睿WAP1'));
	music_002_3_array.push(new cntCode('0027042','河南卓睿WAP2'));
	music_002_3_array.push(new cntCode('0027043','河南卓睿WAP3'));
	music_002_3_array.push(new cntCode('0027044','河南卓睿WAP4'));
	music_002_3_array.push(new cntCode('0027045','河南卓睿WAP5'));
	music_002_3_array.push(new cntCode('0027050','掌发联盟WAP'));
	music_002_3_array.push(new cntCode('0027051','掌发联盟WAP1'));
	music_002_3_array.push(new cntCode('0029600','google WAP'));
	music_002_3_array.push(new cntCode('0029601','google WAP1'));
	music_002_3_array.push(new cntCode('0029610','MSN WAP'));
	music_002_3_array.push(new cntCode('0029611','MSN WAP1'));
	music_002_3_array.push(new cntCode('0029620','临时监测WAP'));
	music_002_3_array.push(new cntCode('0029621','临时监测WAP1'));
	music_002_3_array.push(new cntCode('0029622','临时监测WAP2'));
	music_002_3_array.push(new cntCode('0029630','中兴内置WAP'));
	music_002_3_array.push(new cntCode('0029631','中兴内置WAP1'));
	music_002_3_array.push(new cntCode('0029632','中兴内置WAP2'));
	music_002_3_array.push(new cntCode('0029640','卓望139社区WAP'));
	music_002_3_array.push(new cntCode('0029641','卓望139社区WAP1'));
	music_002_3_array.push(new cntCode('0037200','12530999'));
	music_002_3_array.push(new cntCode('0039901','恒信（语音搜索）'));
	music_002_3_array.push(new cntCode('0039902','呼叫中心'));
	music_002_3_array.push(new cntCode('0041009','结信二期SMS'));
	}
	
	//会员级别
	{
	var music_003_1_array=new Array();
	music_003_1_array.push(new cntCode('0','非会员'));
	music_003_1_array.push(new cntCode('1','普通会员'));
	music_003_1_array.push(new cntCode('2','高级会员'));
	music_003_1_array.push(new cntCode('3','特级会员'));
	}
	
	//操作类型编码表TODO等待修改
	{
	var music_003_2_array=new Array();
	music_003_2_array.push(new cntCode('1', '服务订购'));
	music_003_2_array.push(new cntCode('2', '服务退订'));
	music_003_2_array.push(new cntCode('3', '彩虹包业务订购'));
	music_003_2_array.push(new cntCode('4', '冻结'));
	music_003_2_array.push(new cntCode('5', '解冻'));
	music_003_2_array.push(new cntCode('6', '订购'));
	music_003_2_array.push(new cntCode('7', '退订'));
	music_003_2_array.push(new cntCode('11','注册'));
	music_003_2_array.push(new cntCode('12','注销'));
	music_003_2_array.push(new cntCode('13','变更'));
	music_003_2_array.push(new cntCode('17','改号'));
	music_003_2_array.push(new cntCode('18','彩铃身份变更'));
	music_003_2_array.push(new cntCode('41','服务订购'));
	music_003_2_array.push(new cntCode('42','服务退订'));
	music_003_2_array.push(new cntCode('43','专辑订购'));
	music_003_2_array.push(new cntCode('44','专辑退订'));
	music_003_2_array.push(new cntCode('45','音乐卡订购'));
	music_003_2_array.push(new cntCode('89','彩虹包业务退订'));
	music_003_2_array.push(new cntCode('97','图片包月业务退订'));
	music_003_2_array.push(new cntCode('98','随声听包月业务退订'));
	music_003_2_array.push(new cntCode('99','全业务退订'));
	}
	
	//操作方式编码表
	{
	var music_003_3_array=new Array();
	music_003_3_array.push(new cntCode('001','WWW'));
	music_003_3_array.push(new cntCode('002','WAP'));
	music_003_3_array.push(new cntCode('003','IVR'));
	music_003_3_array.push(new cntCode('004','SMS'));
	music_003_3_array.push(new cntCode('005','USSD'));
	music_003_3_array.push(new cntCode('006','SMP'));
	music_003_3_array.push(new cntCode('007','平台客服'));
	music_003_3_array.push(new cntCode('008','SMAP'));
	music_003_3_array.push(new cntCode('009','BOSS'));
	music_003_3_array.push(new cntCode('010','网管'));
	music_003_3_array.push(new cntCode('011','按键复制'));
	music_003_3_array.push(new cntCode('012','语音搜索'));
	music_003_3_array.push(new cntCode('013','彩铃＋＋平台'));
	music_003_3_array.push(new cntCode('014','手机客户端'));
	music_003_3_array.push(new cntCode('015','综合即时通信（飞信）'));
	music_003_3_array.push(new cntCode('016','12580'));
	music_003_3_array.push(new cntCode('099','其它'));
	}
	
	//下载状态 music_004_1_array
	{
	var music_004_1_array=new Array();
	music_004_1_array.push(new cntCode('000000','成功'));
	music_004_1_array.push(new cntCode('111111','失败'));
	}
	
	//订购类型 music_004_2_array
	{
	var music_004_2_array=new Array();
	music_004_2_array.push(new cntCode('1','彩铃'));
	music_004_2_array.push(new cntCode('2','铃音盒'));
	}
}	
//手机支付
{
	//缴费渠道编码表 pay_002_1_array
	{
		var pay_002_1_array = new Array();
		pay_002_1_array.push(new cntCode('10086 ','移动门户'));
		pay_002_1_array.push(new cntCode('139','139邮箱'));
		pay_002_1_array.push(new cntCode('ATM','自助终端'));
		pay_002_1_array.push(new cntCode('BOSS','营业厅'));
		pay_002_1_array.push(new cntCode('CMPAY','互联网'));
		pay_002_1_array.push(new cntCode('CALL','客服及电话支付系统'));
		pay_002_1_array.push(new cntCode('SMS','短信'));
		pay_002_1_array.push(new cntCode('STK ','SIM卡工具包'));
		pay_002_1_array.push(new cntCode('WAP','无线通讯网'));
		pay_002_1_array.push(new cntCode('SYS','手机支付系统平台'));
		pay_002_1_array.push(new cntCode('FETIO','飞信'));
		pay_002_1_array.push(new cntCode('SP','省平台'));
		pay_002_1_array.push(new cntCode('NETAC','网厅账户'));
		pay_002_1_array.push(new cntCode('NETBK','网厅网银'));
		pay_002_1_array.push(new cntCode('CAS','手机客户端'));
		pay_002_1_array.push(new cntCode('SMSBH','省BOSS短信营业厅'));
		pay_002_1_array.push(new cntCode('IVRBH','省BOSS语音营业厅'));
		pay_002_1_array.push(new cntCode('FEIX1','移动飞信缴话费'));
		pay_002_1_array.push(new cntCode('AHCP','安徽移动手机支付购彩'));
		pay_002_1_array.push(new cntCode('QSYS','全网批扣'));
		pay_002_1_array.push(new cntCode('MS24','云南移动商城'));
		pay_002_1_array.push(new cntCode('MMSMS','电子券到期充话费'));
		pay_002_1_array.push(new cntCode('MOP','开放平台'));
	}
	
	//平台支付状态编码表 pay_002_2_array
	{
		var pay_002_2_array = new Array();
		pay_002_2_array.push(new cntCode('U','预计'));
		pay_002_2_array.push(new cntCode('W','支付申请已发送，等待支付结果'));
		pay_002_2_array.push(new cntCode('G','支付冻结成功'));
		pay_002_2_array.push(new cntCode('S','支付成功'));
		pay_002_2_array.push(new cntCode('F','支付失败'));
		pay_002_2_array.push(new cntCode('C','被冲正'));
		pay_002_2_array.push(new cntCode('T','发送超时'));
		pay_002_2_array.push(new cntCode('X','发送失败'));
		pay_002_2_array.push(new cntCode('D','被撤销'));
		pay_002_2_array.push(new cntCode('B','已退款'));
		pay_002_2_array.push(new cntCode('E','其他错误'));
	}
	//BOSS缴费状态编码表 pay_002_3_array
	{
		var pay_002_3_array = new Array();
		pay_002_3_array.push(new cntCode('U','预计'));
		pay_002_3_array.push(new cntCode('W','缴费申请已发送，等待缴费结果'));
		pay_002_3_array.push(new cntCode('S','缴费成功'));
		pay_002_3_array.push(new cntCode('F','缴费失败'));
		pay_002_3_array.push(new cntCode('C','被冲正'));
		pay_002_3_array.push(new cntCode('T','发送超时'));
		pay_002_3_array.push(new cntCode('X','发送失败'));
		pay_002_3_array.push(new cntCode('D','被撤销'));
		pay_002_3_array.push(new cntCode('E','其他错误'));	
	}
	//BOSS返回码表 pay_002_4_array
	{
		var pay_002_4_array = new Array();
		pay_002_4_array.push(new cntCode('0000','交易成功则无需错误的簇代码，规定为0'));
		pay_002_4_array.push(new cntCode('0101','交换中心发现超时，根据交易属性已发冲正。'));
		pay_002_4_array.push(new cntCode('0102','交换中心发现超时，根据交易属性不发冲正。'));
		pay_002_4_array.push(new cntCode('0103','交换中心发现具有重复发起方交易或业务流水号的交易。'));
		pay_002_4_array.push(new cntCode('0104','交换中心无法根据请求报文找到落地方交换节点。对神州行用户服务亦返回此应答码。'));
		pay_002_4_array.push(new cntCode('0105','发起方交换节点发现Message Header 格式错误'));
		pay_002_4_array.push(new cntCode('0106','发起方交换节点发现报文ServiceContent格式错误。'));
		pay_002_4_array.push(new cntCode('0107','落地方机构检查请求报文格式出错'));
		pay_002_4_array.push(new cntCode('0108','落地方交换节点发现报文Message Header格式错误'));
		pay_002_4_array.push(new cntCode('0109','落地方交换节点发现报文Service Content格式错误'));
		pay_002_4_array.push(new cntCode('0110','发起方交换节点超时，未发冲正'));
		pay_002_4_array.push(new cntCode('0111','交换中心内部错误'));
		pay_002_4_array.push(new cntCode('0112','发起方交换节点内部错误'));
		pay_002_4_array.push(new cntCode('0113','落地方交换节点内部错误'));
		pay_002_4_array.push(new cntCode('0114','OBOSS没开通、签到'));
		pay_002_4_array.push(new cntCode('0115','HBOSS没开通/签到'));
		pay_002_4_array.push(new cntCode('0118','OBOSS未签到此交易测试模式'));
		pay_002_4_array.push(new cntCode('0119','HBOSS未签到此交易测试模式'));
		pay_002_4_array.push(new cntCode('0120','OBOSS未签到此交易正常模式'));
		pay_002_4_array.push(new cntCode('0121','HBOSS未签到此交易正常模式'));
		pay_002_4_array.push(new cntCode('0122','OBOSS未开通此交易测试模式'));
		pay_002_4_array.push(new cntCode('0123','HBOSS未开通此交易测试模式'));
		pay_002_4_array.push(new cntCode('0124','OBOSS未开通此交易正常模式'));
		pay_002_4_array.push(new cntCode('0125','HBOSS未开通此交易正常模式'));
		pay_002_4_array.push(new cntCode('0126','请求报文的BIPcode和ACTIVITY CODE不一致'));
		pay_002_4_array.push(new cntCode('0127','中心缺少对应的对帐记录'));
		pay_002_4_array.push(new cntCode('0128','对帐结果报文中的数量字段与报文中实际的记录数不同'));
		pay_002_4_array.push(new cntCode('0129','中心拒绝发起方与落地方相同的业务'));
		pay_002_4_array.push(new cntCode('0201','交换中心接收到重复的冲正'));
		pay_002_4_array.push(new cntCode('0202','交换中心已经对此交易发起冲正'));
		pay_002_4_array.push(new cntCode('0203','未找到被冲正的交易'));
		pay_002_4_array.push(new cntCode('0205','隔日冲正'));
		pay_002_4_array.push(new cntCode('0206','根据交易类型定义被冲正的交易不可以冲正'));
		pay_002_4_array.push(new cntCode('0207','中心发现原交易已经失败,不需要冲正'));
		pay_002_4_array.push(new cntCode('0291','冲正失败'));
		pay_002_4_array.push(new cntCode('0300','密钥产生失败'));
		pay_002_4_array.push(new cntCode('0301','中心密码重加密失败'));
		pay_002_4_array.push(new cntCode('0302','中心摘要检验失败'));
		pay_002_4_array.push(new cntCode('0310','签到失败'));
		pay_002_4_array.push(new cntCode('0320','签退失败'));
		pay_002_4_array.push(new cntCode('0401','中心未完成此交易日的报文处理'));
		pay_002_4_array.push(new cntCode('0402','只允许查询前一逻辑交易日之前的报文'));
		pay_002_4_array.push(new cntCode('1001','手续费计算错误'));
		pay_002_4_array.push(new cntCode('1002','缴费实付总金额不等于分帐号缴费金额的和'));
		pay_002_4_array.push(new cntCode('1003','智能网方式mzone用户不能异地缴费'));
		pay_002_4_array.push(new cntCode('2001','标识类型错误'));
		pay_002_4_array.push(new cntCode('2002','标识值错误'));
		pay_002_4_array.push(new cntCode('2003','业务类型错误'));
		pay_002_4_array.push(new cntCode('2004','操作代码错误'));
		pay_002_4_array.push(new cntCode('2005','操作时间错误'));
		pay_002_4_array.push(new cntCode('2006','SP企业代码错误'));
		pay_002_4_array.push(new cntCode('2007','SP业务代码错误'));
		pay_002_4_array.push(new cntCode('2014','资料受理信息错误'));
		pay_002_4_array.push(new cntCode('2015','非法用户状态，无法开通业务'));
		pay_002_4_array.push(new cntCode('2101','服务级别错误'));
		pay_002_4_array.push(new cntCode('2102','客服密码验证未通过'));
		pay_002_4_array.push(new cntCode('2103','客户证件类型错误'));
		pay_002_4_array.push(new cntCode('2104','客户证件号码错误'));
		pay_002_4_array.push(new cntCode('2105','开始日期或终止日期错误'));
		pay_002_4_array.push(new cntCode('2107','手机号对应的用户不存在'));
		pay_002_4_array.push(new cntCode('2108','vip卡号对应的大客户不存在'));
		pay_002_4_array.push(new cntCode('2600','省BOSS内部错误'));
		pay_002_4_array.push(new cntCode('2998','专用错误编码'));	
	}
	//补款资金种类编码表 pay_002_5_array
	{
		var pay_002_5_array = new Array();
		pay_002_5_array.push(new cntCode('1','现金'));
		pay_002_5_array.push(new cntCode('2','充值卡'));
		pay_002_5_array.push(new cntCode('3','移动红包'));
		pay_002_5_array.push(new cntCode('4','积分'));
		pay_002_5_array.push(new cntCode('5','商户红包'));	
	}
	//有无账户标志 pay_002_6_array
	{
		var pay_002_6_array = new Array();
		pay_002_6_array.push(new cntCode('0','有账户支付'));
		pay_002_6_array.push(new cntCode('1','非账户支付'));
	}
	
		//和包刷卡卡状态 pay_64_0071_array
	{
		var pay_64_0071_array = new Array();
		pay_64_0071_array.push(new cntCode('0','预开户'));
		pay_64_0071_array.push(new cntCode('1','正常'));
		pay_64_0071_array.push(new cntCode('2','销户'));
		pay_64_0071_array.push(new cntCode('3','暂停'));
	}
	
			//是否签约 pay_64_0091_array
	{
		var pay_64_0091_array = new Array();
		pay_64_0091_array.push(new cntCode('0','协议已解约'));
		pay_64_0091_array.push(new cntCode('1','已签约'));
		pay_64_0091_array.push(new cntCode('2','未签约'));
		pay_64_0091_array.push(new cntCode('3','未知'));
	}
	
				//代扣方式 pay_64_0092_array
	{
		var pay_64_0092_array = new Array();
		pay_64_0092_array.push(new cntCode('0','定额'));
		pay_64_0092_array.push(new cntCode('1','定期'));
	}
	
					//代扣条件 pay_64_0093_array
	{
		var pay_64_0093_array = new Array();
		pay_64_0093_array.push(new cntCode('0','低于某只自动充值'));
		pay_64_0093_array.push(new cntCode('1','每月X号自动充值'));
	}
	
						//短信提醒标志 pay_64_0094_array
	{
		var pay_64_0094_array = new Array();
		pay_64_0094_array.push(new cntCode('0','否'));
		pay_64_0094_array.push(new cntCode('1','是'));
	}
	
							//卡通补款标志 pay_64_0095_array
	{
		var pay_64_0095_array = new Array();
		pay_64_0095_array.push(new cntCode('0','否'));
		pay_64_0095_array.push(new cntCode('1','是'));
	}
	
								//最后一次操作维护类型 pay_64_0096_array
	{
		var pay_64_0096_array = new Array();
		pay_64_0096_array.push(new cntCode('0','解约'));
		pay_64_0096_array.push(new cntCode('1','签阅'));
		pay_64_0096_array.push(new cntCode('2','修改'));
	}
	
									//有效期 pay_64_0111_array
	{
		var pay_64_0111_array = new Array();
		pay_64_0111_array.push(new cntCode('0','本月'));
		pay_64_0111_array.push(new cntCode('1','90天'));
		pay_64_0111_array.push(new cntCode('2','180天'));
	}
	
										//充流量渠道 pay_64_0112_array
	{
		var pay_64_0112_array = new Array();
		pay_64_0112_array.push(new cntCode('THD','外部互联网'));
		pay_64_0112_array.push(new cntCode('CNM','移动自有渠道'));

	}
	
	//电子券状态编码表 pay_002_7_array
	{
		var pay_002_7_array = new Array();
		pay_002_7_array.push(new cntCode('A','已领用'));
		pay_002_7_array.push(new cntCode('U','已使用'));
		pay_002_7_array.push(new cntCode('E','已过期'));
		pay_002_7_array.push(new cntCode('H','已冻结'));
		pay_002_7_array.push(new cntCode('D','已转赠'));
		pay_002_7_array.push(new cntCode('T','已转让'));
		pay_002_7_array.push(new cntCode('W','待转让'));
		pay_002_7_array.push(new cntCode('C','待激活'));
	}

	//红包状态编码表  pay_003_1_array
	{
		var pay_003_1_array = new Array();
		pay_003_1_array.push(new cntCode('A','已领用'));
		pay_003_1_array.push(new cntCode('U','已使用'));
		pay_003_1_array.push(new cntCode('E','已过期'));
		pay_003_1_array.push(new cntCode('H','已冻结'));
		pay_003_1_array.push(new cntCode('D','已转赠'));
		pay_003_1_array.push(new cntCode('T','已转让'));
		pay_003_1_array.push(new cntCode('W','待转让'));	
	}
	//订单状态编码表 pay_004_1_array
	{
		var pay_004_1_array = new Array();
		pay_004_1_array.push(new cntCode('BA','直接支付预登记'));
		pay_004_1_array.push(new cntCode('BB','直接支付用户信息补录成功'));
		pay_004_1_array.push(new cntCode('BC','直接支付金额信息补录成功'));
		pay_004_1_array.push(new cntCode('BD','直接支付订单支付成功'));
		pay_004_1_array.push(new cntCode('BE','直接支付订单关闭'));
		pay_004_1_array.push(new cntCode('BF','直接支付订单作废'));
		pay_004_1_array.push(new cntCode('AA','预授权预登记'));
		pay_004_1_array.push(new cntCode('AB','预授权用户信息补录成功'));
		pay_004_1_array.push(new cntCode('AZ','预授权金额已冻结'));
		pay_004_1_array.push(new cntCode('AC','预授权金额信息补录成功'));
		pay_004_1_array.push(new cntCode('AD','预授权订单支付成功'));
		pay_004_1_array.push(new cntCode('AE','预授权订单关闭'));
		pay_004_1_array.push(new cntCode('AF','预授权订单作废'));
		pay_004_1_array.push(new cntCode('B0','直接支付用户信息补录中'));
		pay_004_1_array.push(new cntCode('B1','直接支付金额信息补录中'));
		pay_004_1_array.push(new cntCode('B2','直接支付付款中'));
		pay_004_1_array.push(new cntCode('B3','直接支付关闭中'));
		pay_004_1_array.push(new cntCode('B4','直接支付批量作废中'));
		pay_004_1_array.push(new cntCode('A0','预授权用户信息补录中'));
		pay_004_1_array.push(new cntCode('A1','预授权金额信息补录中'));
		pay_004_1_array.push(new cntCode('A2','预授权支付付款中'));
		pay_004_1_array.push(new cntCode('A3','预授权支付关闭中'));
		pay_004_1_array.push(new cntCode('A4','预授权支付批量作废中'));
		pay_004_1_array.push(new cntCode('A9','预授权金额冻结中'));
		pay_004_1_array.push(new cntCode('R1','退款中'));
		pay_004_1_array.push(new cntCode('C0','冲正中'));
		pay_004_1_array.push(new cntCode('CC','已冲正'));
		pay_004_1_array.push(new cntCode('ZB','彩票已兑奖'));
		pay_004_1_array.push(new cntCode('RR','退款待处理'));
		pay_004_1_array.push(new cntCode('RQ','退款请求已登记'));
		pay_004_1_array.push(new cntCode('RP','部分退款'));
		pay_004_1_array.push(new cntCode('RF','全部退款'));
		pay_004_1_array.push(new cntCode('P00','预登记'));
    pay_004_1_array.push(new cntCode('PT0','等待付款'));
    pay_004_1_array.push(new cntCode('PRR','退款已受理'));
    pay_004_1_array.push(new cntCode('PRQ','退款已受理'));
    pay_004_1_array.push(new cntCode('PRP','部分退款成功'));
    pay_004_1_array.push(new cntCode('PRF','退款成功'));
    pay_004_1_array.push(new cntCode('PBA','等待付款'));
    pay_004_1_array.push(new cntCode('PBB', '等待付款'));
    pay_004_1_array.push(new cntCode('PBC', '等待付款'));
    pay_004_1_array.push(new cntCode('PBD', '交易成功'));
    pay_004_1_array.push(new cntCode('PBE', '交易关闭'));
    pay_004_1_array.push(new cntCode('PBF', '交易过期'));
    pay_004_1_array.push(new cntCode('PAA', '等待付款'));
    pay_004_1_array.push(new cntCode('PAB', '等待付款'));
    pay_004_1_array.push(new cntCode('PAC', '等待付款'));
    pay_004_1_array.push(new cntCode('PAD', '交易成功'));
    pay_004_1_array.push(new cntCode('PAE', '交易关闭'));
    pay_004_1_array.push(new cntCode('PAF', '交易过期'));
    pay_004_1_array.push(new cntCode('PAZ', '交易成功'));
    pay_004_1_array.push(new cntCode('PB0', '等待付款'));
    pay_004_1_array.push(new cntCode('PB1', '等待付款'));
    pay_004_1_array.push(new cntCode('PB2', '等待付款'));
    pay_004_1_array.push(new cntCode('PB3', '交易关闭'));
    pay_004_1_array.push(new cntCode('PB4', '交易过期'));
    pay_004_1_array.push(new cntCode('PA0', '等待付款'));
    pay_004_1_array.push(new cntCode('PA1', '等待付款'));
    pay_004_1_array.push(new cntCode('PA2', '等待付款'));
    pay_004_1_array.push(new cntCode('PA3', '交易关闭'));
    pay_004_1_array.push(new cntCode('PA4', '交易过期'));
    pay_004_1_array.push(new cntCode('PA9', '等待付款'));
    pay_004_1_array.push(new cntCode('PC0', '交易取消'));
	  pay_004_1_array.push(new cntCode('PCC', '交易取消'));
	}                                   
	//支付类型编码表 pay_004_2_array
	{
		var pay_004_2_array = new Array();	
		pay_004_2_array.push(new cntCode('S','直接支付'));
		pay_004_2_array.push(new cntCode('L','预授权支付'));
		pay_004_2_array.push(new cntCode('C','担保支付'));
		pay_004_2_array.push(new cntCode('B','B2C预授权支付'));
		pay_004_2_array.push(new cntCode('W','无密协议支付'));
		pay_004_2_array.push(new cntCode('U','无密无协议支付'));
	}
	
	//支付方式编码表 pay_005_1_array
	{
		var pay_005_1_array = new Array();	
		pay_005_1_array.push(new cntCode('0','网关支付'));
		pay_005_1_array.push(new cntCode('1','账户支付'));
		pay_005_1_array.push(new cntCode('2','卡通支付'));
		pay_005_1_array.push(new cntCode('3','银行卡支付'));
		pay_005_1_array.push(new cntCode('6','银联语音'));
	}
	
	//订单类型编码表
	{
		var pay_005_2_array = new Array();	
		pay_005_2_array.push(new cntCode('00','消费'));
		pay_005_2_array.push(new cntCode('03','缴话费'));
		pay_005_2_array.push(new cntCode('04','公共事业缴费'));
	}
	
	//业务受理渠道编码表
	{
		var pay_005_3_array = new Array();	
		pay_005_3_array.push(new cntCode('CMPAY','WEB网站'));
		pay_005_3_array.push(new cntCode('WAP','WAP网站'));
		pay_005_3_array.push(new cntCode('SMS','短信渠道'));
		pay_005_3_array.push(new cntCode('STK','SIM卡工具包'));
		pay_005_3_array.push(new cntCode('CAS','客户端'));
		pay_005_3_array.push(new cntCode('IVR','客户语音服务'));
		pay_005_3_array.push(new cntCode('POS','POS服务'));
		pay_005_3_array.push(new cntCode('PORTA','手机支付业务网站'));
	}
	
	//账户类型编码表 pay_006_1_array
	{
		var pay_006_1_array = new Array();	
		pay_006_1_array.push(new cntCode('M','手机支付主账户'));
		pay_006_1_array.push(new cntCode('S','手机支付子账户'));	
	}
	//开销户渠道编码表 pay_006_2_array
	{
		var pay_006_2_array = new Array();	
		pay_006_2_array.push(new cntCode('139','139邮箱'));
    pay_006_2_array.push(new cntCode('BNK','浦发银行'));
    pay_006_2_array.push(new cntCode('BOSS','营业厅'));
    pay_006_2_array.push(new cntCode('BSP','后台批量'));
    pay_006_2_array.push(new cntCode('CAS','手机客户端'));
    pay_006_2_array.push(new cntCode('CMPAY','手机支付业务网站'));
    pay_006_2_array.push(new cntCode('CQNW','重庆移动农网'));
    pay_006_2_array.push(new cntCode('FETIO','飞信'));
    pay_006_2_array.push(new cntCode('NETAC','网厅账户'));
    pay_006_2_array.push(new cntCode('POS','POS机'));
    pay_006_2_array.push(new cntCode('PVP','省平台'));
    pay_006_2_array.push(new cntCode('SMS','短信'));
    pay_006_2_array.push(new cntCode('SYS','手机支付系统平台'));
    pay_006_2_array.push(new cntCode('UI','生产支撑系统'));
    pay_006_2_array.push(new cntCode('WAP','无线通讯网'));
    pay_006_2_array.push(new cntCode('WDM','微博营销'));
    pay_006_2_array.push(new cntCode('CALL','客服系统'));
    pay_006_2_array.push(new cntCode('IVR','自助语音系统'));
    pay_006_2_array.push(new cntCode('ATM','自助终端'));
    pay_006_2_array.push(new cntCode('AGENT','代理点'));
    pay_006_2_array.push(new cntCode('STK','STK渠道'));
    pay_006_2_array.push(new cntCode('MMS','彩信'));
    pay_006_2_array.push(new cntCode('iPOS','IPOS'));
    pay_006_2_array.push(new cntCode('PORTA','网站'));
    pay_006_2_array.push(new cntCode('SCP','充值卡系统'));
    pay_006_2_array.push(new cntCode('WBANK','网银'));
    pay_006_2_array.push(new cntCode('BANK','银行'));
    pay_006_2_array.push(new cntCode('WWW','其它'));
    pay_006_2_array.push(new cntCode('MCLI','客户端'));
    pay_006_2_array.push(new cntCode('PS471', '内蒙古'));
    pay_006_2_array.push(new cntCode('PS100', '北京'));
    pay_006_2_array.push(new cntCode('PS220', '天津'));
    pay_006_2_array.push(new cntCode('PS531', '山东'));
    pay_006_2_array.push(new cntCode('PS311', '河北'));
    pay_006_2_array.push(new cntCode('PS351', '山西'));
    pay_006_2_array.push(new cntCode('PS551', '安徽'));
    pay_006_2_array.push(new cntCode('PS210', '上海'));
    pay_006_2_array.push(new cntCode('PS250', '江苏'));
    pay_006_2_array.push(new cntCode('PS571', '浙江'));
    pay_006_2_array.push(new cntCode('PS591', '福建'));
    pay_006_2_array.push(new cntCode('PS898', '海南'));
    pay_006_2_array.push(new cntCode('PS200', '广东'));
    pay_006_2_array.push(new cntCode('PS771', '广西'));
    pay_006_2_array.push(new cntCode('PS971', '青海'));
    pay_006_2_array.push(new cntCode('PS270', '湖北'));
    pay_006_2_array.push(new cntCode('PS731', '湖南省平台'));
    pay_006_2_array.push(new cntCode('PS791', '江西'));
    pay_006_2_array.push(new cntCode('PS371', '河南'));
    pay_006_2_array.push(new cntCode('PS891', '西藏'));
    pay_006_2_array.push(new cntCode('PS280', '四川'));
    pay_006_2_array.push(new cntCode('PS230', '重庆'));
    pay_006_2_array.push(new cntCode('PS290', '陕西'));
    pay_006_2_array.push(new cntCode('PS851', '贵州'));
    pay_006_2_array.push(new cntCode('PS871', '云南'));
    pay_006_2_array.push(new cntCode('PS931', '甘肃'));
    pay_006_2_array.push(new cntCode('PS951', '宁夏'));
    pay_006_2_array.push(new cntCode('PS991', '新疆'));
    pay_006_2_array.push(new cntCode('PS431', '吉林'));
    pay_006_2_array.push(new cntCode('PS240', '辽宁'));
    pay_006_2_array.push(new cntCode('PS451', '黑龙江'));
    pay_006_2_array.push(new cntCode('PS444', '上海'));
    pay_006_2_array.push(new cntCode('BS731B','湖南营业厅'));
	}
	//账户状态编码表 pay_006_3_array
	{
		var pay_006_3_array = new Array();	
		pay_006_3_array.push(new cntCode('N','正常'));
		pay_006_3_array.push(new cntCode('C','销户'));
		pay_006_3_array.push(new cntCode('W','待销户'));
		pay_006_3_array.push(new cntCode('D','沉默户'));
		pay_006_3_array.push(new cntCode('O','开户'));
	}
	
	//证件类型编码表 pay_006_4_array
	{
		var pay_006_4_array = new Array();	
		pay_006_4_array.push(new cntCode('00','身份证'));
    pay_006_4_array.push(new cntCode('01','VIP卡'));
    pay_006_4_array.push(new cntCode('02','户口簿'));       
    pay_006_4_array.push(new cntCode('03','军人证'));
    pay_006_4_array.push(new cntCode('04','警察证'));
    pay_006_4_array.push(new cntCode('05','港澳居民内地通行证'));
    pay_006_4_array.push(new cntCode('06','台湾居民大陆通行证'));
    pay_006_4_array.push(new cntCode('07','户照'));
    pay_006_4_array.push(new cntCode('08','单位营业执照副本原件'));
    pay_006_4_array.push(new cntCode('09','加盖公章的营业执照复印件'));
    pay_006_4_array.push(new cntCode('99','其它'));
	}
	
	//商品类型编码表 pay_007_1_array
	{
		var pay_007_1_array = new Array();	
		pay_007_1_array.push(new cntCode('2','按次'));
		pay_007_1_array.push(new cntCode('3','包月'));	
	}
}
/*2014/08/05 14:55:41 gaopeng 关于下发一级客服省级业务支撑系统2014年07月批次配合改造要求的通知
	新增业务类别 MobileMarket
*/




{
	/*0—是 1—否*/
	{
				var v_121_005_02_array = new Array();
				v_121_005_02_array.push(new cntCode('0','是'));
				v_121_005_02_array.push(new cntCode('1','否'));
	}	
	/*1 IVR业务，2 客户端业务，3短信业务*/
	
	{
				var v_121_005_01_array = new Array();
				v_121_005_01_array.push(new cntCode('1','IVR业务'));
				v_121_005_01_array.push(new cntCode('2','客户端业务'));
				v_121_005_01_array.push(new cntCode('3','短信业务'));
	}	
	
	/*1 IVR业务，2 客户端业务，3短信业务*/
	{
				var v_121_005_01_array = new Array();
				v_121_005_01_array.push(new cntCode('1','IVR业务'));
				v_121_005_01_array.push(new cntCode('2','客户端业务'));
				v_121_005_01_array.push(new cntCode('3','短信业务'));
	}		
	
	/*
	0：等待支付，1：等待激活，2：激活成功，3：流量耗尽，4：过有效期，5：过期未激活，6订购失败
	*/
	{
				var v_159_001_01_array = new Array();
				v_159_001_01_array.push(new cntCode('0','彩信'));
				v_159_001_01_array.push(new cntCode('1','等待激活'));
				v_159_001_01_array.push(new cntCode('2','激活成功'));
				v_159_001_01_array.push(new cntCode('3','流量耗尽'));
				v_159_001_01_array.push(new cntCode('4','过有效期'));
				v_159_001_01_array.push(new cntCode('5','过期未激活'));
				v_159_001_01_array.push(new cntCode('6','订购失败'));
	}	
	/*
	0：未知，1：申请退订，2：等待退款，3：退订拒绝，4：退款成功，5：退订成功
	*/
	{
				var v_159_001_02_array = new Array();
				v_159_001_02_array.push(new cntCode('0','未知'));
				v_159_001_02_array.push(new cntCode('1','申请退订'));
				v_159_001_02_array.push(new cntCode('2','等待退款'));
				v_159_001_02_array.push(new cntCode('3','退订拒绝'));
				v_159_001_02_array.push(new cntCode('4','退款成功'));
				v_159_001_02_array.push(new cntCode('5','退订成功'));
	}		
	/*
	1：彩信；
	2：短信；
	3：WAP Push
	*/
	{
				var v_42_009_01_array = new Array();
				v_42_009_01_array.push(new cntCode('1','彩信'));
				v_42_009_01_array.push(new cntCode('2','短信'));
				v_42_009_01_array.push(new cntCode('3','WAP Push'));
	}
	/*
	0:银联充值
	8:Appstore充值
	9:联通充值
	*/
	{
		var v_42_008_01_array = new Array();
		v_42_008_01_array.push(new cntCode('0','银联充值'));
		v_42_008_01_array.push(new cntCode('8','Appstore充值'));
		v_42_008_01_array.push(new cntCode('9','联通充值'));
	}
	/*
	0:待充值
	1:充值成功
	2:充值失败
	*/
	{
		var v_42_008_02_array = new Array();
		v_42_008_02_array.push(new cntCode('0','待充值'));
		v_42_008_02_array.push(new cntCode('1','充值成功'));
		v_42_008_02_array.push(new cntCode('2','充值失败'));
	}
		
	/*1、BOSS充值卡
		2、第三方支付
		3、视频点播券
		4、MM点播券
		5、支付宝
		6、金币
		*/
	{
		var v_82_011_01_array = new Array();
		v_82_011_01_array.push(new cntCode('1','BOSS充值卡'));
		v_82_011_01_array.push(new cntCode('2','第三方支付'));
		v_82_011_01_array.push(new cntCode('3','视频点播券'));
		v_82_011_01_array.push(new cntCode('4','MM点播券'));
		v_82_011_01_array.push(new cntCode('5','支付宝'));
		v_82_011_01_array.push(new cntCode('6','金币'));
		
	}
	//0/1（正常/锁定）
	{
		var v_82_009_01_array = new Array();
		v_82_009_01_array.push(new cntCode('0','正常'));
		v_82_009_01_array.push(new cntCode('1','锁定'));
	}
	
	{
		var mm_41_006_001_array = new Array();
		mm_41_006_001_array.push(new cntCode('0','成功'));
		mm_41_006_001_array.push(new cntCode('1','失败'));
	}
	
	{
		var mm_41_007_001_array = new Array();
		mm_41_007_001_array.push(new cntCode('0','不显示'));
		mm_41_007_001_array.push(new cntCode('1','显示'));
	}
	
	
	/*MM订购黑名单查询 返回结果*/
	{
		var mm_41_001_001_array = new Array();
		mm_41_001_001_array.push(new cntCode('0','成功'));
		mm_41_001_001_array.push(new cntCode('1','其他错误，包括网络和数据库错误'));
		mm_41_001_001_array.push(new cntCode('116','号码不合法'));
	}
	/*MM订购黑名单查询 是否黑名单状态*/
	{
		var mm_41_001_002_array = new Array();
		mm_41_001_002_array.push(new cntCode('0','非黑名单状态'));
		mm_41_001_002_array.push(new cntCode('1','黑名单状态'));
	
	}
	
	/*MM订购关系查询 返回结果*/
	{
		var mm_41_002_001_array = new Array();
		mm_41_002_001_array.push(new cntCode('0','成功'));
		mm_41_002_001_array.push(new cntCode('1','其他错误，包括网络和数据库错误'));
	}
	
	/*MM订购关系查询 支付方式*/
	{
		var mm_41_002_002_array = new Array();
		mm_41_002_002_array.push(new cntCode('1','手机支付'));
		mm_41_002_002_array.push(new cntCode('2','实体卡支付'));
		mm_41_002_002_array.push(new cntCode('3','支付宝支付'));
		mm_41_002_002_array.push(new cntCode('4','M券支付'));
		
	}
	/*MM订购关系查询 定购渠道标识*/
	{
		var mm_41_002_003_array = new Array();
		mm_41_002_003_array.push(new cntCode('0','综合支撑服务平台'));
		mm_41_002_003_array.push(new cntCode('1','WWW门户'));
		mm_41_002_003_array.push(new cntCode('2','WAP门户'));
		mm_41_002_003_array.push(new cntCode('3','短信网关'));
		mm_41_002_003_array.push(new cntCode('4','彩信中心'));
		mm_41_002_003_array.push(new cntCode('5','IVR客服系统'));
		mm_41_002_003_array.push(new cntCode('7','BOSS'));
		mm_41_002_003_array.push(new cntCode('8','MISC'));
		mm_41_002_003_array.push(new cntCode('9','运营管理系统(PPMS)'));
		mm_41_002_003_array.push(new cntCode('10','终端门户'));
		mm_41_002_003_array.push(new cntCode('11','第三方SP'));
		mm_41_002_003_array.push(new cntCode('12','第三方门户(139MM)'));
		mm_41_002_003_array.push(new cntCode('13','能力网关OASS'));
		mm_41_002_003_array.push(new cntCode('14','PC门户'));
		mm_41_002_003_array.push(new cntCode('15','应用下载平台AMPD'));
		mm_41_002_003_array.push(new cntCode('16','FMM'));
		mm_41_002_003_array.push(new cntCode('18','mm.139.com'));
		
	}
	
	/*MM订购关系查询 操作类型标识*/
	{
		var mm_41_002_004_array = new Array();
		mm_41_002_004_array.push(new cntCode('','点播下载订单'));
		mm_41_002_004_array.push(new cntCode('0','点播下载订单'));
		mm_41_002_004_array.push(new cntCode('1','赠送下载订单'));
	}
	/*MM订购关系查询 订单标识*/
	{
		var mm_41_002_005_array = new Array();
		mm_41_002_005_array.push(new cntCode('0','应用下载订单'));
		mm_41_002_005_array.push(new cntCode('1','应用使用订单(体验定购订单)'));
		
	}
	/*MM订购关系查询 用户定购的服务类型*/
	{
		var mm_41_002_006_array = new Array();
		mm_41_002_006_array.push(new cntCode('1','点播类业务(按次/免费)'));
		mm_41_002_006_array.push(new cntCode('2','定制类业务(包月)'));
		
	}
	
	/*MM订购黑名单设置 返回结果*/
	{
		var mm_41_003_001_array = new Array();
		mm_41_003_001_array.push(new cntCode('0','成功'));
		mm_41_003_001_array.push(new cntCode('1','其他错误，包括网络和数据库错误'));
		mm_41_003_001_array.push(new cntCode('116','手机号码错误'));
		mm_41_003_001_array.push(new cntCode('426','号码己为黑名单用户'));
		mm_41_003_001_array.push(new cntCode('428','号码己为非黑名单用户'));
		
	}
	
	
}	
//手机阅读
{
	//已经被屏蔽业务 read_001_1_array	
	{
		var read_001_1_array = new Array();
		read_001_1_array.push(new cntCode('0','短信'));
		read_001_1_array.push(new cntCode('1','彩信'));
		read_001_1_array.push(new cntCode('2','Wap Push'));
		read_001_1_array.push(new cntCode('3','图形验证码'));
		read_001_1_array.push(new cntCode('4','订购黑名单用户'));
	}
	//内容类型编码表 read_002_1_array
	{
		var read_002_1_array = new Array();
		read_002_1_array.push(new cntCode('0','所有 '));
		read_002_1_array.push(new cntCode('1','图书'));
		read_002_1_array.push(new cntCode('2','漫画'));
		read_002_1_array.push(new cntCode('3','杂志'));
		read_002_1_array.push(new cntCode('5','听书'));
	}
	//阅读途径编码表 read_002_2_array
	{
		var read_002_2_array = new Array();
		read_002_2_array.push(new cntCode('0','所有 '));
		read_002_2_array.push(new cntCode('1','wap'));
		read_002_2_array.push(new cntCode('2','www'));
		read_002_2_array.push(new cntCode('3','电子书'));
		read_002_2_array.push(new cntCode('4','客户端'));
		read_002_2_array.push(new cntCode('11','平板电脑'));	
	}
	//订购方式编码表 gaopeng 2013/10/22 15:10:10
	{
		var read_002_3_array = new Array();
		read_002_3_array.push(new cntCode('0','免费 '));
		read_002_3_array.push(new cntCode('1','按本'));
		read_002_3_array.push(new cntCode('2','按章'));
		read_002_3_array.push(new cntCode('3','按册'));
		read_002_3_array.push(new cntCode('4','包月'));
		read_002_3_array.push(new cntCode('5','促销包'));	
	}
	//推荐分类 read_003_1_array
	{
		var read_003_1_array = new Array();
		read_003_1_array.push(new cntCode('1','图书'));
		read_003_1_array.push(new cntCode('2','漫画'));
		read_003_1_array.push(new cntCode('3','杂志'));
	}
	//资费说明 read_003_2_array
	{
		var read_003_2_array = new Array();
		read_003_2_array.push(new cntCode('0','免费'));
		read_003_2_array.push(new cntCode('1','按本'));
		read_003_2_array.push(new cntCode('2','按章'));
		read_003_2_array.push(new cntCode('3','按字'));
		read_003_2_array.push(new cntCode('4','包月'));
		//平台人通知5为促销包
		read_003_2_array.push(new cntCode('5','促销包'));
	}
	//最近订/退途径 read_005_1_array
	{
		var read_005_1_array = new Array();
		read_005_1_array.push(new cntCode('1','wap'));
		read_005_1_array.push(new cntCode('2','www'));
		read_005_1_array.push(new cntCode('3','手持终端'));
		read_005_1_array.push(new cntCode('4','客户端软件'));
		read_005_1_array.push(new cntCode('5','客服'));
		read_005_1_array.push(new cntCode('6','boss'));
		read_005_1_array.push(new cntCode('7','短信'));
	}
	//状态 read_005_2_array
	{
		var read_005_2_array = new Array();
		read_005_2_array.push(new cntCode('0','订购中'));
		read_005_2_array.push(new cntCode('1','已订购'));
		read_005_2_array.push(new cntCode('2','暂停'));
		read_005_2_array.push(new cntCode('7','订购失败'));
		read_005_2_array.push(new cntCode('8','退订中'));
		read_005_2_array.push(new cntCode('9','已退订'));
	}
	//计费方式 read_006_1_array
	{
		var read_006_1_array = new Array();
		read_006_1_array.push(new cntCode('0','全部'));
		read_006_1_array.push(new cntCode('2','按章订购'));
		read_006_1_array.push(new cntCode('1','按本订购'));
		read_006_1_array.push(new cntCode('7','按册订购'));
		read_006_1_array.push(new cntCode('5','促销包订购'));	
	}
	//订购途径 read_006_2_array
	{
		var read_006_2_array = new Array();
		read_006_2_array.push(new cntCode('1','wap'));
		read_006_2_array.push(new cntCode('2','www'));
		read_006_2_array.push(new cntCode('3','手持终端'));
		read_006_2_array.push(new cntCode('4','客户端软件'));
		read_006_2_array.push(new cntCode('5','客服'));
		read_006_2_array.push(new cntCode('6','boss'));
		read_006_2_array.push(new cntCode('7','短信'));
	}
	//消费方式 编码表 2013/10/22 15:33:17 gaopeng 关于下发省级CRM系统配合一级客服系统2013年8月批次改造方案的通知
	{
		var read_006_3_array = new Array();
		read_006_3_array.push(new cntCode('0','免费'));
		read_006_3_array.push(new cntCode('1','按本计费'));
		read_006_3_array.push(new cntCode('2','按章计费'));
		read_006_3_array.push(new cntCode('3','按千字计费'));
		read_006_3_array.push(new cntCode('4','包月'));	
		read_006_3_array.push(new cntCode('5','促销包计费'));	
		read_006_3_array.push(new cntCode('7','按册计费'));	
		read_006_3_array.push(new cntCode('15','按本计费'));	
	}
	//绑定状态编码表 2013/10/22 14:51:01 gaopeng 关于下发省级CRM系统配合一级客服系统2013年8月批次改造方案的通知
	{
		var read_007_1_array = new Array();
		read_007_1_array.push(new cntCode('0','绑定成功'));
		read_007_1_array.push(new cntCode('1','未绑定'));
		read_007_1_array.push(new cntCode('2','绑定处理中'));
		read_007_1_array.push(new cntCode('3','解绑处理中'));
		read_007_1_array.push(new cntCode('4','绑定失败'));
		read_007_1_array.push(new cntCode('5','解绑失败'));
		read_007_1_array.push(new cntCode('6','绑定暂停成功'));
		read_007_1_array.push(new cntCode('7','绑定恢复成功'));
		read_007_1_array.push(new cntCode('8','绑定暂停处理中'));
		read_007_1_array.push(new cntCode('9','绑定恢复处理中'));
		read_007_1_array.push(new cntCode('10','绑定暂停失败'));
		read_007_1_array.push(new cntCode('11','绑定恢复失败'));
		read_007_1_array.push(new cntCode('12','绑定停机暂停'));
		read_007_1_array.push(new cntCode('13','绑定挂失暂停(BOSS发起)'));
		
	}
	//绑定解绑方式编码表 2013/10/22 14:51:01 gaopeng 关于下发省级CRM系统配合一级客服系统2013年8月批次改造方案的通知
	{
		var read_007_2_array = new Array();
		read_007_2_array.push(new cntCode('1','终端'));
		read_007_2_array.push(new cntCode('2','短信'));
		read_007_2_array.push(new cntCode('3','BOSS'));
		read_007_2_array.push(new cntCode('4','平台'));
		read_007_2_array.push(new cntCode('-1',''));
	}
	
}
//手机游戏
{
	//名单级别 game_001_1_array
	{
		var game_001_1_array = new Array();
		game_001_1_array.push(new cntCode('1','禁止所有业务计费'));
	}
	//黑名单来源 game_001_2_array
	{
		var game_001_2_array = new Array();
		game_001_2_array.push(new cntCode('1','BOC'));
		game_001_2_array.push(new cntCode('2','客服'));
		game_001_2_array.push(new cntCode('3','CPID(指特定合作方提交的黑名单用户)'));
	}
	//状态 game_001_3_array
	{
		var game_001_3_array = new Array();
		game_001_3_array.push(new cntCode('0','无效'));
		game_001_3_array.push(new cntCode('1','有效'));
	}
	
	
	//支付类型编码表 game_002_1_array
	{
		var game_002_1_array = new Array();
		game_002_1_array.push(new cntCode('1','点数'));
		game_002_1_array.push(new cntCode('2','话费'));
	}
	//计费方式编码表 game_002_2_array
	{
		var game_002_2_array = new Array();
		game_002_2_array.push(new cntCode('1','免费'));
		game_002_2_array.push(new cntCode('2','按次/按条计费'));
		game_002_2_array.push(new cntCode('3','包月计费'));
		game_002_2_array.push(new cntCode('5','包次计费'));
		game_002_2_array.push(new cntCode('7','包天计费'));
		game_002_2_array.push(new cntCode('9','按栏目包月计费'));	
	}
	//充值方式编码表 game_002_3_array
	{
		var game_002_3_array = new Array();
		game_002_3_array.push(new cntCode('1','手机话费充值'));
		game_002_3_array.push(new cntCode('2','M值积分兑换'));
		game_002_3_array.push(new cntCode('3','手机钱包充值'));
		game_002_3_array.push(new cntCode('9','其他方式'));
	}
	//订购方式编码表 game_003_1_array
	{
		var game_003_1_array = new Array();
		game_003_1_array.push(new cntCode('1','SMS'));
		game_003_1_array.push(new cntCode('2','WAP'));
		game_003_1_array.push(new cntCode('3','客户端'));
		game_003_1_array.push(new cntCode('4','WEB'));
		game_003_1_array.push(new cntCode('5','营业厅'));
		game_003_1_array.push(new cntCode('599','[省测]一级BOSS（99）'));
		game_003_1_array.push(new cntCode('508','[省测]营业厅（08）'));
		game_003_1_array.push(new cntCode('6','批量订购/退订网元'));
		game_003_1_array.push(new cntCode('507','[省测]10086（07）'));
		game_003_1_array.push(new cntCode('501','[省测]SMS（01）'));
		game_003_1_array.push(new cntCode('502','[省测]网上营业厅（02）'));
		game_003_1_array.push(new cntCode('503','[省测]WAP（03）'));
		game_003_1_array.push(new cntCode('504','[省测]WEB（04）'));
		game_003_1_array.push(new cntCode('500','[省测]其他（00）'));
		game_003_1_array.push(new cntCode('7','客服'));
		game_003_1_array.push(new cntCode('99','其他方式'));	
	}
	//订购状态编码表 game_003_2_array
	{
		var game_003_2_array = new Array();
		game_003_2_array.push(new cntCode('0','预订购'));
		game_003_2_array.push(new cntCode('1','已正式订购'));
		game_003_2_array.push(new cntCode('2','暂停'));
		game_003_2_array.push(new cntCode('3','预订购取消(当月已退订，但仍可使用)'));
		game_003_2_array.push(new cntCode('4','订购关系停步（等待删除）'));
	}
	
	//查询类型编码表 game_004_1_array
	{
		var game_004_1_array = new Array();
		game_004_1_array.push(new cntCode('1','电话号码'));
		game_004_1_array.push(new cntCode('2','用户伪码'));
	}
	//结果状态 game_004_2_array
	{
		var game_004_2_array = new Array();
		game_004_2_array.push(new cntCode('0','成功'));
		game_004_2_array.push(new cntCode('1','失败'));
	}
	//用户类型编码表 game_004_3_array
	{
		var game_004_3_array = new Array();
		game_004_3_array.push(new cntCode('0','预订购'));
		game_004_3_array.push(new cntCode('1','已正式订购'));
		game_004_3_array.push(new cntCode('2','暂停（目前系统暂时没有该值，保留）'));
		game_004_3_array.push(new cntCode('3','预订购取消（当月已退定，但仍可使用）'));
		game_004_3_array.push(new cntCode('4','订购关系停步（等待删除）'));
	}
	//类型 game_006_1_array 2600话费充值点数，2700非话费充值点数
	{
		var game_006_1_array = new Array();	
		game_006_1_array.push(new cntCode('2600','话费点数'));
		game_006_1_array.push(new cntCode('2700','第三方支付点数'));	
		game_006_1_array.push(new cntCode('2800','通用赠送点数'));
		game_006_1_array.push(new cntCode('2900','指定赠送点数'));
	}
	
	//游戏业务类型编码表 game_007_1_array
	{
		var game_007_1_array = new Array();
		game_007_1_array.push(new cntCode('1','客户端单机'));
		game_007_1_array.push(new cntCode('2','客户端网游'));
		game_007_1_array.push(new cntCode('3','网页单机'));
		game_007_1_array.push(new cntCode('4','网页网游'));
		game_007_1_array.push(new cntCode('5','试玩转激活单点'));
		game_007_1_array.push(new cntCode('6','试玩转激活多点'));
		game_007_1_array.push(new cntCode('7','普通短息'));
		game_007_1_array.push(new cntCode('8','普通彩信'));
		game_007_1_array.push(new cntCode('9','月租业务'));
		game_007_1_array.push(new cntCode('99','游戏包'));
	}
	
		//游戏业务状态编码表 game_007_11_array
	{
		var game_007_11_array = new Array();
		game_007_11_array.push(new cntCode('1','草稿'));
		game_007_11_array.push(new cntCode('2','测试'));
		game_007_11_array.push(new cntCode('3','商用'));
		game_007_11_array.push(new cntCode('4','暂停'));
		game_007_11_array.push(new cntCode('5','下线'));

	}	
	
	//号码来源
    {
        var game_008_1_array = new Array();
        game_008_1_array.push(new cntCode('0','未知'));
        game_008_1_array.push(new cntCode('1','短信上行'));
        game_008_1_array.push(new cntCode('2','用户投诉'));
        game_008_1_array.push(new cntCode('3','地市反馈'));
    }
    /*2014/08/05 14:17:52 gaopeng 57_010 灰名单来源*/
    {
        var game_57_010_01_array = new Array();
        game_57_010_01_array.push(new cntCode('1','BOC'));
        game_57_010_01_array.push(new cntCode('2','客服'));
        game_57_010_01_array.push(new cntCode('3','CPID'));
        
    }
    /*2014/08/05 14:17:52 gaopeng 57_011 核查结果*/
    {
        var game_57_011_01_array = new Array();
        game_57_011_01_array.push(new cntCode('1','正常'));
        game_57_011_01_array.push(new cntCode('2','建议进一步核查'));
    }
    
    /*2014/08/05 14:17:52 gaopeng 57_012 手机游戏 操作类型*/
    {
        var game_57_012_01_array = new Array();
        game_57_012_01_array.push(new cntCode('1','游戏启动'));
        game_57_012_01_array.push(new cntCode('2','游戏付费'));
        game_57_012_01_array.push(new cntCode('3','包月订购'));
        game_57_012_01_array.push(new cntCode('4','折扣订购'));
        game_57_012_01_array.push(new cntCode('5','游戏退出'));
        game_57_012_01_array.push(new cntCode('6','CP自定义'));
        game_57_012_01_array.push(new cntCode('10','登陆'));
        game_57_012_01_array.push(new cntCode('11','登出'));
        game_57_012_01_array.push(new cntCode('12','计费'));
        game_57_012_01_array.push(new cntCode('13','图形验证码'));
        game_57_012_01_array.push(new cntCode('14','短信验证码'));
        game_57_012_01_array.push(new cntCode('15','图形智能问答'));
        game_57_012_01_array.push(new cntCode('16','免登录验证'));
    }
    
}
//手机视频
{
	//黑名单查询 被屏蔽业务 media_001_1_array	
	{
		var media_001_1_array = new Array();
		media_001_1_array.push(new cntCode('1','短信业务'));
		media_001_1_array.push(new cntCode('2','彩信业务'));
		media_001_1_array.push(new cntCode('3','WAP业务'));
	} 
	//计费类型编码表  media_002_1_array	/*2014/08/05 10:11:39 gaopeng 更新编码表 加入15 16 */	
	{
		var media_002_1_array = new Array();	
		media_002_1_array.push(new cntCode('-1','全部'));
		media_002_1_array.push(new cntCode('0','包月'));
		media_002_1_array.push(new cntCode('1','按次'));
		media_002_1_array.push(new cntCode('7','免费'));
		media_002_1_array.push(new cntCode('13','包多月'));
		media_002_1_array.push(new cntCode('15','大包月'));
		media_002_1_array.push(new cntCode('16','平台包月产品'));
	}
	//操作途径编码表 media_002_2_array	
	{
		var media_002_2_array = new Array();
		media_002_2_array.push(new cntCode('1100','新客户端'));
		media_002_2_array.push(new cntCode('1200','简化UI'));
		media_002_2_array.push(new cntCode('1300','MM客户端'));
		media_002_2_array.push(new cntCode('1400','WAP'));
		media_002_2_array.push(new cntCode('1500','WWW'));
		media_002_2_array.push(new cntCode('1600','Iphone'));
		media_002_2_array.push(new cntCode('1700','Ipad'));
		media_002_2_array.push(new cntCode('1800','老客户端'));	
	}
	//操作记录编码表 media_002_3_array
	{
		var media_002_3_array = new Array();	
		media_002_3_array.push(new cntCode('1','订购'));
		media_002_3_array.push(new cntCode('2','删除'));
		media_002_3_array.push(new cntCode('3','修改'));
		media_002_3_array.push(new cntCode('4','停机'));
		media_002_3_array.push(new cntCode('5','复机'));
		media_002_3_array.push(new cntCode('6','其他'));
	}
	//查询结果 media_005_1_array
	{
		var media_005_1_array = new Array();	
		media_005_1_array.push(new cntCode('YES','是'));
		media_005_1_array.push(new cntCode('NO','否'));
		media_005_1_array.push(new cntCode('ERROR','非法查询'));
	}
}

//手机电视 zhouby add
{
	//业务类型码表 bizType_001_1_array	
	{
		var bizType_001_1_array = new Array();
		bizType_001_1_array.push(new cntCode('003','主动密钥请求'));
		bizType_001_1_array.push(new cntCode('004','业务订购'));
		bizType_001_1_array.push(new cntCode('005','业务开通'));
		bizType_001_1_array.push(new cntCode('006','GBA初始化'));
		bizType_001_1_array.push(new cntCode('007','SG业务下载'));
		bizType_001_1_array.push(new cntCode('008','订购密钥请求'));
		bizType_001_1_array.push(new cntCode('009','订购关系'));
		bizType_001_1_array.push(new cntCode('010','订购关系更新'));
		bizType_001_1_array.push(new cntCode('010','订购关系更新日志查询'));
		bizType_001_1_array.push(new cntCode('011','开放最新订购记录查询'));
	} 
	//内部错误编码表  error_002_1_array	
	{
		var error_002_1_array = new Array();	
		error_002_1_array.push(new cntCode('15402','NAF向BSF进行密钥请求，携带的NAFID不可信，请确认终端是否正常'));
		error_002_1_array.push(new cntCode('15403','NAF向BSF进行密钥请求，密钥请求失败，请确认终端是否正常'));
		error_002_1_array.push(new cntCode('10280','BSF向HLR请求鉴权元组，HLR返回错误响应，请确认该用户卡是否正常'));
		error_002_1_array.push(new cntCode('10281','BSF向HLR请求鉴权元组，请求消息超时，请确认BSF-sigtran-STP-HLR的链路是否正常'));
		error_002_1_array.push(new cntCode('10282','终端向BSF进行注册认证请求，BSF系统错误从而返回注册认证失败，请检查BSF设备运行是否正常'));
		error_002_1_array.push(new cntCode('10283','终端向BSF进行注册认证请求，BSF向HLR获取鉴权元组失败从而返回注册认证失败，请确认HLR是否正常'));
		error_002_1_array.push(new cntCode('10284','终端向BSF进行鉴权认证请求，BSF向加密机获取密钥消息发送失败从而返回鉴权认证失败，请检查BSF与加密机之间的链路'));
		error_002_1_array.push(new cntCode('10285','终端向BSF进行鉴权认证请求，加密机返回获取密钥失败响应从而返回鉴权认证失败，请确认终端是否正常'));
		error_002_1_array.push(new cntCode('10286','终端向BSF进行鉴权认证请求，BSF向加密机获取密钥超时从而返回鉴权认证失败，请检查加密机是否运行正常'));
		error_002_1_array.push(new cntCode('10287','终端向BSF进行鉴权认证请求，BSF系统错误从而返回鉴权认证失败，请检查BSF设备运行是否正常'));
		error_002_1_array.push(new cntCode('10288','终端向BSF进行鉴权认证请求，终端携带的nonce与BSF内部不一致从而返回鉴权认证失败，请确认终端是否正常'));
		error_002_1_array.push(new cntCode('10289','终端向BSF进行鉴权认证请求，终端携带的response与BSF内部不一致从而返回鉴权认证失败，请确认终端是否正常'));
		error_002_1_array.push(new cntCode('16001','NAF向BSF进行PUSHGBA请求，BSF向HLR获取鉴权元组消息发送失败'));
		error_002_1_array.push(new cntCode('16002','NAF向BSF进行PUSHGBA请求，HLR返回获取鉴权元组失败'));
		error_002_1_array.push(new cntCode('16003','NAF向BSF进行PUSHGBA请求，BSF向HLR获取鉴权元组请求消息超时'));
		error_002_1_array.push(new cntCode('17001','NAF向BSF进行GETKEY请求，BSF向加密机获取密钥信息消息发送失败'));
		error_002_1_array.push(new cntCode('17002','NAF向BSF进行GETKEY请求，加密机返回获取密钥信息失败'));
		error_002_1_array.push(new cntCode('17003','NAF向BSF进行GETKEY请求，BSF向加密机获取密钥请求消息超时'));
		error_002_1_array.push(new cntCode('17004','NAF向BSF进行GETKEY请求，无该BTID信息'));
		error_002_1_array.push(new cntCode('18001','NAF向BSF进行第一个BITD删除操作，BSF返回删除失败'));
		error_002_1_array.push(new cntCode('18002','NAF向BSF进行两个BITD删除操作，BSF返回全部删除失败'));
		error_002_1_array.push(new cntCode('18003','NAF向BSF进行两个BITD删除操作，BSF返回BITD1删除失败'));
		error_002_1_array.push(new cntCode('18004','NAF向BSF进行两个BITD删除操作，BSF返回BITD2删除失败'));
		error_002_1_array.push(new cntCode('21120','终端的发起的请求消息不合法，请确认终端版本正确。'));
		error_002_1_array.push(new cntCode('21220','终端向平台发起请求，平台已经是开通状态，请退出终端重新更新用户开通关系。'));
		error_002_1_array.push(new cntCode('21221','终端向平台发起请求，平台已经是注销状态，请退出终端重新更新用户开通关系。'));
		error_002_1_array.push(new cntCode('21223','终端向平台发起请求，平台已经是暂停状态，请退出终端重新更新用户开通关系。'));
		error_002_1_array.push(new cntCode('22200','平台向移动boss发起请求，中移boss返回用户不存在(24)，请联系中移BOSS解决。'));
		error_002_1_array.push(new cntCode('22202','平台向移动boss发起请求，中移boss返回错误码不在规范定义的范围内，请联系中移BOSS解决。'));
		error_002_1_array.push(new cntCode('22203','平台向移动boss发起请求，中移boss无响应，请联系中移BOSS解决。'));
		error_002_1_array.push(new cntCode('22220','平台向移动boss发起请求，中移boss返回用户已经开通手机电视业务(11)，请联系中移BOSS解决。'));
		error_002_1_array.push(new cntCode('22221','平台向移动boss发起请求，中移boss返回用户尚未开通手机电视业务(12)，请联系中移BOSS解决。'));
		error_002_1_array.push(new cntCode('22281','平台向移动boss发起请求，中移boss返回企业代码错误(01)，请联系中移BOSS解决。'));
		error_002_1_array.push(new cntCode('22282','平台向移动boss发起请求，中移boss返回操作代码错误(02)，请联系中移BOSS解决。'));
		error_002_1_array.push(new cntCode('22283','平台向移动boss发起请求，中移boss返回业务代码错误(03)，请联系中移BOSS解决。'));
		error_002_1_array.push(new cntCode('22284','平台向移动boss发起请求，中移boss返回生效时间错误(04)，请联系中移BOSS解决。'));
		error_002_1_array.push(new cntCode('22285','平台向移动boss发起请求，中移boss返回用户已停机(21)，请联系中移BOSS解决。'));
		error_002_1_array.push(new cntCode('22286','平台向移动boss发起请求，中移boss返回用户已销户(23)，请联系中移BOSS解决。'));
		error_002_1_array.push(new cntCode('22287','平台向移动boss发起请求，中移boss返回系统内部错误(98)，请联系中移BOSS解决。'));
		error_002_1_array.push(new cntCode('22288','平台向移动boss发起请求，中移boss返回操作不成功(99)，请联系中移BOSS解决。'));
		error_002_1_array.push(new cntCode('23120','平台向广电boss发起请求，广电boss返回消息格式不对(120)，请联系广电BOSS解决。'));
		error_002_1_array.push(new cntCode('23200','平台向广电boss发起请求，广电boss返回用户不存在(200)，请联系广电BOSS解决。'));
		error_002_1_array.push(new cntCode('23220','平台向广电boss发起请求，广电boss返回用户已经开通手机电视业务(220)，请联系广电BOSS解决。'));
		error_002_1_array.push(new cntCode('23221','平台向广电boss发起请求，广电boss返回用户尚未开通手机电视业务(221)，请联系广电BOSS解决。'));
		error_002_1_array.push(new cntCode('23223','平台向广电boss发起请求，广电boss返回用户暂停了手机电视业务(223)，请联系广电BOSS解决。'));
		error_002_1_array.push(new cntCode('23203','平台向广电boss发起请求，广电boss无响应，请联系广电BOSS解决。'));
		error_002_1_array.push(new cntCode('23201','平台向广电boss发起请求，广电boss返回错误码不在规范定义的范围内，请联系广电BOSS解决。'));
		error_002_1_array.push(new cntCode('30601','向LBAP发送消息失败,请联系业务平台解决'));
		error_002_1_array.push(new cntCode('30602','向GIS发送消息失败，请联系业务平台解决'));
		error_002_1_array.push(new cntCode('30603','LBAP返回错误，请联系定位网关解决'));
		error_002_1_array.push(new cntCode('30604','GIS返回错误，请联系定位网关解决'));
		error_002_1_array.push(new cntCode('30605','向NAF发送消息失败，请联系业务平台NAF解决'));
		error_002_1_array.push(new cntCode('30606','NAF没有返回手机号码，请检查终端所携带的B-TID是否正确'));
		error_002_1_array.push(new cntCode('30008','终端请求消息错误，请检查终端消息格式'));
		error_002_1_array.push(new cntCode('30028','根据终端所在城市没有查找到对应的业务指南，请确认终端所在城市是否正确'));
		error_002_1_array.push(new cntCode('41003','未知的订购项,请检查用户请求携带的套餐ID是否正确。'));
		error_002_1_array.push(new cntCode('41230','订购确认请求，广电BOSS返回业务不存在(230)，请联系广电BOSS解决'));
		error_002_1_array.push(new cntCode('41231','订购确认请求，广电BOSS返回业务状态不正常(231)，请联系广电BOSS解决'));
		error_002_1_array.push(new cntCode('41603','平台向中移BOSS请求，中移BOSS返回业务代码错误(03)，请联系中移BOSS解决'));
		error_002_1_array.push(new cntCode('41027','平台检查用户正在使用套餐，不允许用户进行套餐的变更'));
		error_002_1_array.push(new cntCode('41030','平台检查用户处于未开通或暂停状态，请用户先开通，再进行订购操作'));
		error_002_1_array.push(new cntCode('41221','订购确认请求，广电BOSS返回用户未开通(221)，请联系广电BOSS解决'));
		error_002_1_array.push(new cntCode('41223','订购确认请求，广电BOSS返回用户已经暂停(223)，请联系广电BOSS解决'));
		error_002_1_array.push(new cntCode('41613','平台向中移BOSS请求，中移BOSS返回用户没有订购基础业务(13)，请联系中移BOSS解决'));
		error_002_1_array.push(new cntCode('41008','终端请求的消息错误。'));
		error_002_1_array.push(new cntCode('41201','平台向广电BOSS发送请求，广电BOSS返回服务器系统忙(201)，请联系广电BOSS解决。'));
		error_002_1_array.push(new cntCode('41120','平台向广电BOSS发送请求，广电BOSS返回消息合理性错误(120)，请联系广电BOSS解决。'));
		error_002_1_array.push(new cntCode('41200','平台向广电BOSS发送请求，广电BOSS返回消息路由错误(200)，请联系广电BOSS解决。'));
		error_002_1_array.push(new cntCode('41241','平台向广电BOSS发送请求，广电BOSS返回用户没有订购(241)，请联系广电BOSS解决。'));
		error_002_1_array.push(new cntCode('41242','平台向广电BOSS发送请求，广电BOSS返回需要二次确认(242)，请联系广电BOSS解决。'));
		error_002_1_array.push(new cntCode('41243','平台向广电BOSS发送请求，广电BOSS返回用户对业务的订购关系状态不正常(243)，请联系广电BOSS解决。'));
		error_002_1_array.push(new cntCode('41244','平台向广电BOSS发送请求，广电BOSS返回拒绝订购（244），请联系广电BOSS解决。'));
		error_002_1_array.push(new cntCode('41245','平台向中移BOSS发送请求，中移BOSS返回不在规范定义中的失败代码，请联系中移BOSS解决。'));
		error_002_1_array.push(new cntCode('41501','平台向广电BOSS发送请求，广电BOSS超时没有返回响应消息，请联系广电BOSS解决。'));
		error_002_1_array.push(new cntCode('41502','平台向广电BOSS发送请求失败，请联系业务平台解决。'));
		error_002_1_array.push(new cntCode('41503','平台向广电BOSS发送请求，广电BOSS返回未知含义的失败代码，请联系广电BOSS解决。'));
		error_002_1_array.push(new cntCode('41601','平台向中移BOSS发送请求，中移BOSS返回企业代码错误(01)，请联系中移BOSS解决。'));
		error_002_1_array.push(new cntCode('41602','平台向中移BOSS发送请求，中移BOSS返回操作代码错误(02)，请联系中移BOSS解决。'));
		error_002_1_array.push(new cntCode('41604','平台向中移BOSS发送请求，中移BOSS返回生效时间错误(04)，请联系中移BOSS解决。'));
		error_002_1_array.push(new cntCode('41611','平台向中移BOSS发送请求，中移BOSS返回用户已订购该业务(11)，请联系中移BOSS解决。'));
		error_002_1_array.push(new cntCode('41612','平台向中移BOSS发送请求，中移BOSS返回用户未订购该业务或已退订(12)，请联系中移BOSS解决。'));
		error_002_1_array.push(new cntCode('41620','平台向中移BOSS发送请求，中移BOSS返回用户已单向停机(20)，请联系中移BOSS解决。'));
		error_002_1_array.push(new cntCode('41621','平台向中移BOSS发送请求，中移BOSS返回用户已停机(21)，请联系中移BOSS解决。'));
		error_002_1_array.push(new cntCode('41622','平台向中移BOSS发送请求，中移BOSS返回用户预销户(22)，请联系中移BOSS解决。'));
		error_002_1_array.push(new cntCode('41623','平台向中移BOSS发送请求，中移BOSS返回用户销户(23)，请联系中移BOSS解决。'));
		error_002_1_array.push(new cntCode('41624','平台向中移BOSS发送请求，中移BOSS返回用户不存在(24)，请联系中移BOSS解决。'));
		error_002_1_array.push(new cntCode('41625','平台向中移BOSS发送请求，中移BOSS返回用户余额不足(25)，请联系中移BOSS解决。'));
		error_002_1_array.push(new cntCode('41626','平台向中移BOSS发送请求，中移BOSS返回不允许订购(26)，请联系中移BOSS解决。'));
		error_002_1_array.push(new cntCode('41696','平台向中移BOSS发送请求失败，请联系业务平台解决。'));
		error_002_1_array.push(new cntCode('41697','平台向中移BOSS发送请求，中移BOSS超时没有返回响应，请联系中移BOSS解决。'));
		error_002_1_array.push(new cntCode('41698','平台向中移BOSS发送请求，中移BOSS返回落地方内部错误(98)，请联系中移BOSS解决。'));
		error_002_1_array.push(new cntCode('41699','平台向中移BOSS发送请求，中移BOSS返回其它错误(99)，请联系中移BOSS解决。'));
		error_002_1_array.push(new cntCode('41202','平台向广电BOSS发送请求，广电BOSS返回服务器无响应(202)，请联系广电BOSS解决。'));
		error_002_1_array.push(new cntCode('43120','平台向广电BOSS发送请求，广电BOSS返回消息合理性错误(120)，请联系广电BOSS解决。'));
		error_002_1_array.push(new cntCode('43200','平台向广电BOSS发送请求，广电BOSS返回消息路由错误(200)，请联系广电BOSS解决。'));
		error_002_1_array.push(new cntCode('43201','平台向广电BOSS发送请求，广电BOSS返回服务器忙(201)，请联系广电BOSS解决。'));
		error_002_1_array.push(new cntCode('43202','平台向广电BOSS发送请求，广电BOSS返回服务器无响应(202)，请联系广电BOSS解决。'));
		error_002_1_array.push(new cntCode('43240','平台向广电BOSS发送请求，广电BOSS返回已经订购(240)，请联系广电BOSS解决。'));
		error_002_1_array.push(new cntCode('43241','平台向广电BOSS发送请求，广电BOSS返回用户没有订购(241)，请联系广电BOSS解决。'));
		error_002_1_array.push(new cntCode('43242','平台向广电BOSS发送请求，广电BOSS返回需要二次确认(242)，请联系广电BOSS解决。'));
		error_002_1_array.push(new cntCode('43244','平台向广电BOSS发送请求，广电系统拒绝订购(244)或未知错误，请联系广电BOSS解决。  '));
		error_002_1_array.push(new cntCode('43501','平台向广电BOSS发送请求，广电BOSS超时没有返回响应消息，请联系广电BOSS解决。'));
		error_002_1_array.push(new cntCode('43502','平台向广电BOSS发送请求失败，请联系业务平台解决'));
		error_002_1_array.push(new cntCode('43503','平台向广电BOSS发送请求，广电BOSS返回未知含义的失败代码，请联系广电BOSS解决。'));
		error_002_1_array.push(new cntCode('43221','平台向广电BOSS发送请求，广电BOSS返回用户未开通(221)，请联系广电BOSS解决。'));
		error_002_1_array.push(new cntCode('43223','平台向广电BOSS发送请求，广电BOSS返回用户暂停(223)，请联系广电BOSS解决。'));
		error_002_1_array.push(new cntCode('43230','平台向广电BOSS发送请求，广电BOSS返回业务不存在(230)，请联系广电BOSS解决。'));
		error_002_1_array.push(new cntCode('43231','平台向广电BOSS发送请求，广电BOSS返回业务状态不正常(231)，请联系广电BOSS解决。'));
		error_002_1_array.push(new cntCode('43243','平台向广电BOSS发送请求，广电BOSS返回用户对该业务的订购关系的状态不正常(243)，请联系广电BOSS解决。'));
		error_002_1_array.push(new cntCode('44230','未知的订购项,请检查请求携带的套餐ID是否正确。'));
		error_002_1_array.push(new cntCode('44603','平台向中移BOSS请求，中移BOSS返回业务代码错误(03)，请联系中移BOSS解决'));
		error_002_1_array.push(new cntCode('44120','请求消息格式不符合规范，请联系二线客服平台解决。'));
		error_002_1_array.push(new cntCode('44200','返回消息路由错误，请联系手机电视平台解决。'));
		error_002_1_array.push(new cntCode('44601','平台向中移BOSS发送请求，中移BOSS返回企业代码错误(01)，请联系中移BOSS解决。'));
		error_002_1_array.push(new cntCode('44602','平台向中移BOSS发送请求，中移BOSS返回操作代码错误(02)，请联系中移BOSS解决。'));
		error_002_1_array.push(new cntCode('44604','平台向中移BOSS发送请求，中移BOSS返回生效时间错误(04)，请联系中移BOSS解决。'));
		error_002_1_array.push(new cntCode('44611','平台向中移BOSS发送请求，中移BOSS返回用户已订购该业务(11)，请联系中移BOSS解决。'));
		error_002_1_array.push(new cntCode('44612','平台向中移BOSS发送请求，中移BOSS返回用户未订购该业务或已退订(12)，请联系中移BOSS解决。'));
		error_002_1_array.push(new cntCode('44613','平台向中移BOSS请求，中移BOSS返回用户没有订购基础业务(13)，请联系中移BOSS解决'));
		error_002_1_array.push(new cntCode('44620','平台向中移BOSS发送请求，中移BOSS返回用户已单向停机(20)，请联系中移BOSS解决。'));
		error_002_1_array.push(new cntCode('44621','平台向中移BOSS发送请求，中移BOSS返回用户已停机(21)，请联系中移BOSS解决。'));
		error_002_1_array.push(new cntCode('44624','平台向中移BOSS发送请求，中移BOSS返回用户不存在(24)，请联系中移BOSS解决。'));
		error_002_1_array.push(new cntCode('44625','平台向中移BOSS发送请求，中移BOSS返回用户余额不足(25)，请联系中移BOSS解决。'));
		error_002_1_array.push(new cntCode('44626','平台向中移BOSS发送请求，中移BOSS返回不允许订购(26)，请联系中移BOSS解决。'));
		error_002_1_array.push(new cntCode('44696','平台向中移BOSS发送请求失败，请联系业务平台解决。'));
		error_002_1_array.push(new cntCode('44697','平台向中移BOSS发送请求，中移BOSS超时没有返回响应，请联系中移BOSS解决。'));
		error_002_1_array.push(new cntCode('44698','平台向中移BOSS发送请求，中移BOSS返回落地方内部错误(98)，请联系中移BOSS解决。'));
		error_002_1_array.push(new cntCode('44699','平台向中移BOSS发送请求，中移BOSS返回其它错误(99)，请联系中移BOSS解决。'));
		error_002_1_array.push(new cntCode('44245','平台向中移BOSS发送请求，中移BOSS返回的失败代码不在规范描述的范围内，请联系中移BOSS解决。'));
		error_002_1_array.push(new cntCode('50001','GBA初始化请求，终端未携带手机号码,请联系终端以及WAP网关解决。'));
		error_002_1_array.push(new cntCode('50002','GBA初始化请求，平台未能查到BSF地址信息,请联系业务平台看终端号段是否配置。'));
		error_002_1_array.push(new cntCode('50003','GBA初始化请求, 终端发送的Http消息不合法,请联系终端解决。'));
		error_002_1_array.push(new cntCode('51001','终端发起客户端开通/恢复/暂停/注销请求,终端未携带手机号码,请联系终端以及WAP网关解决。'));
		error_002_1_array.push(new cntCode('51002','终端发起客户端开通/恢复/暂停/注销请求,终端发送的Authorization头不合法,请联系终端解决。'));
		error_002_1_array.push(new cntCode('51003','终端发起客户端开通/恢复/暂停/注销请求,终端发送的Http Digest消息类型不合法,请联系终端解决。'));
		error_002_1_array.push(new cntCode('51004','终端发起客户端开通/恢复/暂停/注销请求,终端发送的Http 消息体不合法,请联系终端解决。'));
		error_002_1_array.push(new cntCode('51005','终端发起客户端开通/恢复/暂停/注销请求,Http Digest鉴权失败(NONCE不等,RESPONSE相等),请联系终端解决。'));
		error_002_1_array.push(new cntCode('51006','终端发起客户端开通/恢复/暂停/注销请求,Http Digest鉴权失败(NONCE不等,RESPONSE不等),请联系终端解决。'));
		error_002_1_array.push(new cntCode('51007','终端发起客户端开通/恢复/暂停/注销请求,Http Digest鉴权失败(NONCE相等,RESPONSE不等),请联系终端解决。'));
		error_002_1_array.push(new cntCode('51008','终端发起客户端开通/恢复/暂停/注销请求,Http Digest鉴权失败(从BSF获取MRK失败),请联系终端以及业务平台解决。'));
		error_002_1_array.push(new cntCode('52001','终端发起客户端订购/退订请求,终端未携带手机号码,请联系终端以及WAP网关解决。'));
		error_002_1_array.push(new cntCode('52002','终端发起客户端订购/退订请求,终端发送的Authorization头不合法,请联系终端解决。'));
		error_002_1_array.push(new cntCode('52003','终端发起客户端订购/退订请求,终端发送的Http Digest消息类型不合法,请联系终端解决。'));
		error_002_1_array.push(new cntCode('52004','终端发起客户端订购/退订请求,终端发送的Http消息体不合法,请联系终端解决。'));
		error_002_1_array.push(new cntCode('52005','终端发起客户端订购/退订请求,Http Digest鉴权失败(NONCE不等,RESPONSE相等),请联系终端解决。'));
		error_002_1_array.push(new cntCode('52006','终端发起客户端订购/退订请求,Http Digest鉴权失败(NONCE不等,RESPONSE不等),请联系终端解决。'));
		error_002_1_array.push(new cntCode('52007','终端发起客户端订购/退订请求,Http Digest鉴权失败(NONCE相等,RESPONSE不等),请联系终端解决。'));
		error_002_1_array.push(new cntCode('52008','终端发起客户端订购/退订请求,Http Digest鉴权失败(从BSF获取MRK失败),请联系终端以及业务平台解决。'));
		error_002_1_array.push(new cntCode('52009','终端发起客户端订购/退订请求,Http Digest鉴权失败(PESPONSE不等,NEWRESPONSE相等),请联系终端以及业务平台解决。'));
		error_002_1_array.push(new cntCode('52010','终端发起客户端订购/退订请求,Http Digest鉴权失败(PESPONSE相等,NEWRESPONSE不等),请联系终端以及业务平台解决。'));
		error_002_1_array.push(new cntCode('52011','端发起客户端订购/退订请求,Http Digest鉴权失败(PESPONSE不等,NEWRESPONSE不等),请联系终端以及业务平台解决。'));
		error_002_1_array.push(new cntCode('52012','终端发起客户端订购/退订请求,Http Digest鉴权失败(从BSF获取KEY失败),请联系终端以及业务平台解决。'));
		error_002_1_array.push(new cntCode('00299','平台返回服务器忙,请联系业务平台解决'));
		error_002_1_array.push(new cntCode('00300','用户号码所在号段不存在，请确认用户手机号码是否正常'));
		error_002_1_array.push(new cntCode('61001','平台向移动BOSS发起请求，移动BOSS返回企业代码错误(01)，请联系业务平台和移动BOSS分析处理。'));
		error_002_1_array.push(new cntCode('61002','平台向移动BOSS发起请求，移动BOSS返回操作代码错误(02)，请联系业务平台和移动BOSS分析处理。'));
		error_002_1_array.push(new cntCode('61003','平台向移动BOSS发起请求，移动BOSS返回业务代码错误(03)，请联系业务平台和移动BOSS分析处理。'));
		error_002_1_array.push(new cntCode('61004','平台向移动BOSS发起请求，移动BOSS返回生效时间错误(04)，请联系业务平台和移动BOSS分析处理。'));
		error_002_1_array.push(new cntCode('61011','平台向移动BOSS发起请求，移动BOSS返回用户已开通/订购该业务(11)，请联系业务平台和移动BOSS分析处理。'));
		error_002_1_array.push(new cntCode('61012','平台向移动BOSS发起请求，移动BOSS返回用户未开通/订购该业务或已退订(12)，请联系业务平台和移动BOSS分析处理。'));
		error_002_1_array.push(new cntCode('61013','平台向移动BOSS发起请求，移动BOSS返回用户未开通，所以不能进行套餐的订购(13)，请联系业务平台和移动BOSS分析处理。'));
		error_002_1_array.push(new cntCode('61020','平台向移动BOSS发起请求，移动BOSS返回用户已单向停机(20)，请联系移动BOSS分析处理。'));
		error_002_1_array.push(new cntCode('61021','平台向移动BOSS发起请求，移动BOSS返回用户已停机(21)，请联系移动BOSS分析处理。'));
		error_002_1_array.push(new cntCode('61022','平台向移动BOSS发起请求，移动BOSS返回用户预销户(22)，请联系移动BOSS分析处理。'));
		error_002_1_array.push(new cntCode('61023','平台向移动BOSS发起请求，移动BOSS返回用户销户(23)，请联系移动BOSS分析处理。'));
		error_002_1_array.push(new cntCode('61024','平台向移动BOSS发起请求，移动BOSS返回用户不存在(24)，请联系移动BOSS分析处理。'));
		error_002_1_array.push(new cntCode('61025','平台向移动BOSS发起请求，移动BOSS返回用户余额不足(25)，请联系移动BOSS分析处理。'));
		error_002_1_array.push(new cntCode('61026','平台向移动BOSS发起请求，移动BOSS返回不允许订购(因客户信用管理导致不允许订购手机电视业务)(26)，请联系移动BOSS分析处理。'));
		error_002_1_array.push(new cntCode('61098','平台向移动BOSS发起请求，移动BOSS返回系统错误(98)，请联系移动BOSS分析处理。'));
		error_002_1_array.push(new cntCode('61099','平台向移动BOSS发起请求，移动BOSS返回操作失败(99)，请联系移动BOSS分析处理。'));
		error_002_1_array.push(new cntCode('61999','平台向移动BOSS发起请求，移动BOSS超时没有返回响应，请联系移动BOSS分析处理'));
		error_002_1_array.push(new cntCode('61050','平台向移动BOSS发起请求，移动BOSS返回规范未定义错误，请联系移动BOSS分析处理'));
		error_002_1_array.push(new cntCode('62001','移动BOSS向平台发起请求，平台返回企业代码错误，请联系业务平台和移动BOSS分析处理。'));
		error_002_1_array.push(new cntCode('62002','移动BOSS向平台发起请求，平台返回操作代码错误，请联系业务平台和移动BOSS分析处理。'));
		error_002_1_array.push(new cntCode('62003','移动BOSS向平台发起请求，平台返回业务代码错误，请联系业务平台和移动BOSS分析处理。'));
		error_002_1_array.push(new cntCode('62004','移动BOSS向平台发起请求，平台返回生效时间错误，请联系业务平台和移动BOSS分析处理。'));
		error_002_1_array.push(new cntCode('62011','移动BOSS向平台发起请求，平台返回用户已开通该业务，请联系业务平台和移动BOSS分析处理。'));
		error_002_1_array.push(new cntCode('62111','移动BOSS向平台发起请求，广电BOSS返回用户已开通该业务(220)，请联系广电BOSS分析处理。'));
		error_002_1_array.push(new cntCode('62012','移动BOSS向平台发起请求，平台返回用户未开通该业务，请联系业务平台和移动BOSS分析处理。'));
		error_002_1_array.push(new cntCode('62112','移动BOSS向平台发起请求，广电BOSS返回用户未开通该业务(221)，请联系广电BOSS分析处理。'));
		error_002_1_array.push(new cntCode('62013','移动BOSS向平台发起请求，平台返回用户未开通，所以不能进行套餐的订购，请联系业务平台和移动BOSS分析处理。'));
		error_002_1_array.push(new cntCode('62024','移动BOSS向平台发起请求，平台返回用户不存在，请联系业务平台分析处理。'));
		error_002_1_array.push(new cntCode('62124','移动BOSS向平台发起请求，广电BOSS返回用户不存在(200)，请联系广电BOSS分析处理。'));
		error_002_1_array.push(new cntCode('62098','移动BOSS向平台发起请求，平台返回内部错误，请联系业务平台分析处理。'));
		error_002_1_array.push(new cntCode('62099','移动BOSS向平台发起请求，平台返回用户手机终端消息不合法，请联系用户的手机终端厂家分析处理。'));
		error_002_1_array.push(new cntCode('62199','移动BOSS向平台发起请求，平台返回用户已暂停，请联系业务平台和移动BOSS分析处理。'));
		error_002_1_array.push(new cntCode('62299','移动BOSS向平台发起请求，广电BOSS返回未知错误，请联系广电BOSS分析处理。'));
		error_002_1_array.push(new cntCode('62399','移动BOSS向平台发起请求，广电BOSS超时，请联系广电BOSS分析处理。'));
		error_002_1_array.push(new cntCode('62499','移动BOSS向平台发起请求，广电BOSS返回消息解析错误(120)，请联系广电BOSS分析处理。'));
		error_002_1_array.push(new cntCode('62198','移动BOSS向平台发起请求，平台返回服务器忙，请稍后再试'));
		error_002_1_array.push(new cntCode('62298','移动BOSS向平台发起请求，平台返回服务器不支持，请确认发起的请求操作是否在现网支持'));
		error_002_1_array.push(new cntCode('62599','移动BOSS向平台发起请求，广电BOSS返回用户已暂停(223)，请联系广电BOSS分析处理。'));
		error_002_1_array.push(new cntCode('63001','移动BOSS向平台发起请求，平台返回企业代码错误，请联系业务平台和移动BOSS分析处理。'));
		error_002_1_array.push(new cntCode('63002','移动BOSS向平台发起请求，平台返回操作代码错误，请联系业务平台和移动BOSS分析处理。'));
		error_002_1_array.push(new cntCode('63003','移动BOSS向平台发起请求，平台返回业务代码错误，请联系业务平台和移动BOSS分析处理。'));
		error_002_1_array.push(new cntCode('63004','移动BOSS向平台发起请求，平台返回生效时间错误，请联系业务平台和移动BOSS分析处理。'));
		error_002_1_array.push(new cntCode('63103','移动BOSS向平台发起请求，平台返回未知的订购项，请联系移动BOSS检查订购携带的套餐ID是否正确。'));
		error_002_1_array.push(new cntCode('63203','移动BOSS向平台发起请求，平台向广电BOSS发送订购确认请求，广电BOSS返回业务不存在(230)，请联系广电BOSS解决'));
		error_002_1_array.push(new cntCode('63303','移动BOSS向平台发起请求，平台向广电BOSS发送订购确认请求，广电BOSS返回业务状态不正常(231)，请联系广电BOSS解决'));
		error_002_1_array.push(new cntCode('63011','移动BOSS向平台发起请求，广电BOSS返回已经订购(240)，请联系广电BOSS解决。'));
		error_002_1_array.push(new cntCode('63012','移动BOSS向平台发起请求，广电BOSS返回用户没有订购(241)，请联系广电BOSS解决。'));
		error_002_1_array.push(new cntCode('63013','移动BOSS向平台发起请求，平台检查用户处于未开通或暂停状态，请联系移动BOSS先开通，再进行订购操作。'));
		error_002_1_array.push(new cntCode('63113','移动BOSS向平台发起请求，平台向广电BOSS发送订购确认请求，广电BOSS返回用户未开通(221)，请联系广电BOSS解决。'));
		error_002_1_array.push(new cntCode('63213','移动BOSS向平台发起请求，平台向广电BOSS发送订购确认请求，广电BOSS返回用户已经暂停(223)，请联系广电BOSS解决。'));
		error_002_1_array.push(new cntCode('63024','移动BOSS向平台发起请求，平台检查用户号码所在号段不存在，请联系业务平台解决。'));
		error_002_1_array.push(new cntCode('63098','移动BOSS向平台发起请求，平台返回内部错误，请联系业务平台解决。'));
		error_002_1_array.push(new cntCode('63099','移动BOSS向平台发起请求，平台向广电BOSS发送请求失败，请联系业务平台解决。'));
		error_002_1_array.push(new cntCode('63199','移动BOSS向平台发起请求，广电BOSS返回服务器系统忙(201)，请联系广电BOSS解决'));
		error_002_1_array.push(new cntCode('63299','移动BOSS向平台发起请求，广电BOSS返回消息合理性错误(120)，请联系广电BOSS解决。'));
		error_002_1_array.push(new cntCode('63399','移动BOSS向平台发起请求，广电BOSS返回消息路由错误(200)，请联系广电BOSS解决。'));
		error_002_1_array.push(new cntCode('63499','移动BOSS向平台发起请求，广电BOSS返回需要二次确认(242)，请联系广电BOSS解决。'));
		error_002_1_array.push(new cntCode('63599','移动BOSS向平台发起请求，广电BOSS返回用户对业务的订购关系状态不正常(243)，请联系广电BOSS解决。'));
		error_002_1_array.push(new cntCode('63699','平台向广电BOSS发送请求，广电BOSS返回拒绝订购（244），请联系广电BOSS解决。'));
		error_002_1_array.push(new cntCode('63799','移动BOSS向平台发起请求，广电BOSS返回支撑系统拒绝订购(245)，请联系广电BOSS解决。'));
		error_002_1_array.push(new cntCode('63899','移动BOSS向平台发起请求，广电BOSS超时没有返回响应消息，请联系广电BOSS解决。'));
		error_002_1_array.push(new cntCode('63999','移动BOSS向平台发起请求，广电BOSS返回服务器无响应(202)，请联系广电BOSS解决。'));
		error_002_1_array.push(new cntCode('63000','平台向广电BOSS发送请求，广电BOSS返回未知含义的失败代码，请联系广电BOSS解决。'));
		error_002_1_array.push(new cntCode('63990','移动BOSS向平台发起请求，移动BOSS请求消息的操作类型错误，请联系移动BOSS解决'));
		error_002_1_array.push(new cntCode('63198','移动BOSS向平台发起请求，NAF订购模块超时没有返回响应消息，请联系业务平台解决。'));
		error_002_1_array.push(new cntCode('64001','移动BOSS向平台发起订购信息变更通知请求，平台返回该用户的订购关系不存在，请联系业务平台解决。'));
		error_002_1_array.push(new cntCode('64002','移动BOSS向平台发起订购信息变更通知请求，平台返回该用户的全部业务已退订。'));
		error_002_1_array.push(new cntCode('64003','移动BOSS向平台发起订购信息变更通知请求，平台返回该用户的全部业务已暂停。'));
		error_002_1_array.push(new cntCode('64004','移动BOSS向平台发起订购信息变更通知请求，平台返回该用户的全部业务已恢复。'));
		error_002_1_array.push(new cntCode('64005','移动BOSS向平台发起订购信息变更通知请求，平台返回移动BOSS发起消息不合法，请联系业务平台解决。'));
		error_002_1_array.push(new cntCode('64201','移动BOSS向平台发起订购信息变更通知请求，广电BOSS返回未知错误，请联系广电BOSS解决。'));
		error_002_1_array.push(new cntCode('64203','移动BOSS向平台发起订购信息变更通知请求，广电BOSS超时无响应，请联系广电BOSS解决。'));
		error_002_1_array.push(new cntCode('64120','移动BOSS向平台发起订购信息变更通知请求，广电BOSS返回消息无法解析(120)，请联系广电BOSS解决。'));
		error_002_1_array.push(new cntCode('64200','移动BOSS向平台发起订购信息变更通知请求，广电BOSS返回用户不存在(200)，请联系广电BOSS解决。'));
		error_002_1_array.push(new cntCode('64220','移动BOSS向平台发起订购信息变更通知请求，广电BOSS返回用户已开通(220)。'));
		error_002_1_array.push(new cntCode('64221','移动BOSS向平台发起订购信息变更通知请求，广电BOSS返回用户未开通(221)。'));
		error_002_1_array.push(new cntCode('64223','移动BOSS向平台发起订购信息变更通知请求，广电BOSS返回用户已暂停(223)。'));
		error_002_1_array.push(new cntCode('64288','移动BOSS向平台发起订购信息变更通知请求，平台返回服务器不支持，请确认发起的请求操作是否在现网支持'));
		error_002_1_array.push(new cntCode('64101','移动BOSS向平台发起订购信息变更通知请求，平台返回服务器忙，请稍后再试'));
		error_002_1_array.push(new cntCode('64099','移动BOSS向平台发起订购信息变更通知请求，平台返回操作失败，请联系业务平台处理。'));
		error_002_1_array.push(new cntCode('65003','移动BOSS向平台发起订购信息变更通知请求，平台返回业务代码错误，请联系业务平台和移动BOSS分析处理。'));
		error_002_1_array.push(new cntCode('65230','移动BOSS向平台发起订购信息变更通知请求，平台向广电BOSS发送订购确认请求，广电BOSS返回业务不存在(230)，请联系广电BOSS解决'));
		error_002_1_array.push(new cntCode('65231','移动BOSS向平台发起订购信息变更通知请求，平台向广电BOSS发送订购确认请求，广电BOSS返回业务状态不正常(231)，请联系广电BOSS解决'));
		error_002_1_array.push(new cntCode('65013','移动BOSS向平台发起订购信息变更通知请求，平台检查用户处于未开通或暂停状态，请联系移动BOSS先开通，再进行订购操作。'));
		error_002_1_array.push(new cntCode('65221','移动BOSS向平台发起订购信息变更通知请求，平台向广电BOSS发送订购确认请求，广电BOSS返回用户未开通(221)，请联系广电BOSS解决。'));
		error_002_1_array.push(new cntCode('65223','移动BOSS向平台发起订购信息变更通知请求，平台向广电BOSS发送订购确认请求，广电BOSS返回用户已经暂停(223)，请联系广电BOSS解决。'));
		error_002_1_array.push(new cntCode('65201','移动BOSS向平台发起订购信息变更通知请求，广电BOSS返回服务器系统忙(201)，请联系广电BOSS解决。'));
		error_002_1_array.push(new cntCode('65202','移动BOSS向平台发起订购信息变更通知请求，广电BOSS返回服务器无响应(202)，请联系广电BOSS解决。'));
		error_002_1_array.push(new cntCode('65120','移动BOSS向平台发起订购信息变更通知请求，广电BOSS返回消息合理性错误(120)，请联系广电BOSS解决。'));
		error_002_1_array.push(new cntCode('65200','移动BOSS向平台发起订购信息变更通知请求，广电BOSS返回消息路由错误(200)，请联系广电BOSS解决。'));
		error_002_1_array.push(new cntCode('65240','移动BOSS向平台发起订购信息变更通知请求，广电BOSS返回已经订购(240)，请联系广电BOSS解决。'));
		error_002_1_array.push(new cntCode('65241','移动BOSS向平台发起订购信息变更通知请求，广电BOSS返回用户没有订购(241)，请联系广电BOSS解决。'));
		error_002_1_array.push(new cntCode('65012','移动BOSS向平台发起订购信息变更通知请求，移动BOSS向平台发起退订请求，平台查询用户尚未订购该业务。'));
		error_002_1_array.push(new cntCode('65242','移动BOSS向平台发起订购信息变更通知请求，广电BOSS返回需要二次确认(242)，请联系广电BOSS解决。'));
		error_002_1_array.push(new cntCode('65243','移动BOSS向平台发起订购信息变更通知请求，广电BOSS返回用户对业务的订购关系状态不正常(243)，请联系广电BOSS解决。'));
		error_002_1_array.push(new cntCode('65244','移动BOSS向平台发起订购信息变更通知请求，广电BOSS返回拒绝订购（244）或者未知含义的失败代码，请联系广电BOSS解决。'));
		error_002_1_array.push(new cntCode('65501','移动BOSS向平台发起订购信息变更通知请求，广电BOSS超时没有返回响应消息，请联系广电BOSS解决。'));
		error_002_1_array.push(new cntCode('65502','移动BOSS向平台发起订购信息变更通知请求，平台向广电BOSS发送请求失败，请联系业务平台解决。'));
		error_002_1_array.push(new cntCode('65503','移动BOSS向平台发起订购信息变更通知请求，广电BOSS返回未知含义的失败代码，请联系广电BOSS解决。'));
		error_002_1_array.push(new cntCode('65098','移动BOSS向平台发起订购信息变更通知请求，平台返回内部错误，请联系业务平台解决。'));
		error_002_1_array.push(new cntCode('65024','移动BOSS向平台发起订购信息变更通知请求，平台检查用户号码所在号段不存在，请联系业务平台解决。'));
		error_002_1_array.push(new cntCode('65093','移动BOSS向平台发起订购信息变更请求，操作类型错误，请先检查用户当前的订购关系状态。'));
		error_002_1_array.push(new cntCode('65099','移动BOSS向平台发起订购信息变更请求，操作类型错误，请先检查用户当前的订购关系状态。'));
		error_002_1_array.push(new cntCode('70001','终端发起主动密钥请求,终端未携带手机号码,请联系终端以及WAP网关解决。'));
		error_002_1_array.push(new cntCode('70002','终端发起主动密钥请求,终端发送的Authorization头不合法,请联系终端解决。'));
		error_002_1_array.push(new cntCode('70003','终端发起主动密钥请求,终端发送的Http Digest消息类型不合法,请联系终端解决。'));
		error_002_1_array.push(new cntCode('70004','终端发起主动密钥请求,终端发送的Http消息体不合法,请联系终端解决。'));
		error_002_1_array.push(new cntCode('70005','终端发起主动密钥请求,Http Digest鉴权失败(NONCE不等,RESPONSE相等),请联系终端解决。'));
		error_002_1_array.push(new cntCode('70006','终端发起主动密钥请求,Http Digest鉴权失败(NONCE不等,RESPONSE不等),请联系终端解决。'));
		error_002_1_array.push(new cntCode('70007','终端发起主动密钥请求,Http Digest鉴权失败(NONCE相等,RESPONSE不等),请联系终端解决。'));
		error_002_1_array.push(new cntCode('70008','终端发起主动密钥请求,Http Digest鉴权失败(从BSF获取MRK失败),请联系终端以及业务平台解决。'));
		error_002_1_array.push(new cntCode('70009','终端发起主动密钥请求,终端开通关系鉴权失败(未开通),请联系终端解决。'));
		error_002_1_array.push(new cntCode('70010','终端发起主动密钥请求,终端订购关系鉴权失败(未订购),请联系终端解决。'));
		error_002_1_array.push(new cntCode('70011','终端发起主动密钥请求,终端携带的Mskid/Keydomainid不对,请联系终端解决。'));
		error_002_1_array.push(new cntCode('70012','终端发起主动密钥请求,终端余额不足，已经暂停手机电视业务,请联系终端解决'));
		error_002_1_array.push(new cntCode('71001','终端发起主动密钥请求,广电CAS超时没有回响应,请联系广电CAS解决。'));
		error_002_1_array.push(new cntCode('71002','终端发起主动密钥请求,广电CAS返回的Http消息体不合法,请联系广电CAS解决。'));
		error_002_1_array.push(new cntCode('71003','终端发起主动密钥请求,广电CAS返回获取密钥失败(返回码未知),请联系广电CAS解决。'));
		error_002_1_array.push(new cntCode('71004','终端发起主动密钥请求,广电CAS返回获取密钥失败(返回码显示成功,但是密钥为空),请联系广电CAS解决。'));
		error_002_1_array.push(new cntCode('71005','终端发起主动密钥请求,广电CAS返回获取密钥失败(广电侧返回错误的Mskid/Keydomainid),请联系广电CAS解决。'));
		error_002_1_array.push(new cntCode('71011','终端发起主动密钥请求,广电CAS返回获取密钥失败(返回码显示网络故障,1),请联系广电CAS解决。'));
		error_002_1_array.push(new cntCode('71221','终端发起主动密钥请求,广电CAS返回获取密钥失败(返回码显示未开通,221),请联系广电CAS解决。'));
		error_002_1_array.push(new cntCode('71223','终端发起主动密钥请求,广电CAS返回获取密钥失败(返回码显示已暂停,223),请联系广电CAS解决。'));
		error_002_1_array.push(new cntCode('71230','终端发起主动密钥请求,广电CAS返回获取密钥失败(返回码显示业务不存在,230),请联系广电CAS解决。'));
		error_002_1_array.push(new cntCode('71231','终端发起主动密钥请求,广电CAS返回获取密钥失败(返回码显示业务状态不正常,231),请联系广电CAS解决。'));
		error_002_1_array.push(new cntCode('71241','终端发起主动密钥请求,广电CAS返回获取密钥失败(返回码显示未订购,241),请联系广电CAS解决。'));
		error_002_1_array.push(new cntCode('71243','终端发起主动密钥请求,广电CAS返回获取密钥失败(返回码显示订购关系不正常,243),请联系广电CAS解决。'));
	}
}

//咪咕动漫
{
  //资费说明编码表
  {
    var fee_003_1_array = new Array();
		fee_003_1_array.push(new cntCode('0','免费'));
		fee_003_1_array.push(new cntCode('1','按本'));
		fee_003_1_array.push(new cntCode('2','按章'));
		fee_003_1_array.push(new cntCode('3','按字'));
		fee_003_1_array.push(new cntCode('4','包月'));
  }
  {
    var fee_003_11_array = new Array();
		fee_003_11_array.push(new cntCode('0','全选'));
		fee_003_11_array.push(new cntCode('1','短信'));
		fee_003_11_array.push(new cntCode('2','彩信'));
		fee_003_11_array.push(new cntCode('3','集团彩漫'));
		fee_003_11_array.push(new cntCode('4','WapPush'));
		fee_003_11_array.push(new cntCode('5','动漫导视'));
		fee_003_11_array.push(new cntCode('6','限制消费'));

  }
  
  

   {
   	//黑名单操作结果（0：成功/1：失败）
    var fee_003_113_array = new Array();
		fee_003_113_array.push(new cntCode('1','短信'));
		fee_003_113_array.push(new cntCode('2','彩信'));
		fee_003_113_array.push(new cntCode('3','集团彩漫'));
		fee_003_113_array.push(new cntCode('4','Wap Push'));
		fee_003_113_array.push(new cntCode('5','动漫导视'));
		fee_003_113_array.push(new cntCode('7','动漫杂志（短信）'));
		fee_003_113_array.push(new cntCode('8','动漫杂志（彩信）'));
		fee_003_113_array.push(new cntCode('9','个人彩漫'));
		fee_003_113_array.push(new cntCode('21','限制点播'));
		fee_003_113_array.push(new cntCode('22','限制包月'));
		fee_003_113_array.push(new cntCode('23','限制漫币消费'));
		fee_003_113_array.push(new cntCode('24','限制积分累计'));
		fee_003_113_array.push(new cntCode('25','限制购买漫币'));
		fee_003_113_array.push(new cntCode('26','限制个人彩漫'));
  } 
  
   {
   	//黑名单操作结果（0：成功/1：失败）
    var fee_003_112_array = new Array();
		fee_003_112_array.push(new cntCode('0','成功'));
		fee_003_112_array.push(new cntCode('1','失败'));
  } 
  
  {
    var fee_003_12_array = new Array();
		fee_003_12_array.push(new cntCode('1','屏蔽'));
		fee_003_12_array.push(new cntCode('2','非屏蔽'));
  }   
  /*2014/08/05 9:10:50 gaopeng 异常行为用户查询 查询结果 关于下发一级客服省级业务支撑系统2014年07月批次配合改造要求的通知（能力开放接口）*/
  {
  	var anim_95_004_array = new Array();
  	anim_95_004_array.push(new cntCode('0','是'));
  	anim_95_004_array.push(new cntCode('1','否'));
  }
  
  /* 0：订购、1：取消 */
 	{
				var v_95_010_01_array = new Array();
				v_95_010_01_array.push(new cntCode('0','订购'));
				v_95_010_01_array.push(new cntCode('1','取消'));
	}
  /* 0：成功、1：失败 */
 	{
				var v_95_010_02_array = new Array();
				v_95_010_02_array.push(new cntCode('0','成功'));
				v_95_010_02_array.push(new cntCode('1','失败'));
	}

  /* 1：上行、2：下行 */
 	{
				var v_95_013_01_array = new Array();
				v_95_013_01_array.push(new cntCode('1','上行'));
				v_95_013_01_array.push(new cntCode('2','下行'));
	}

  /* 1：正常  2：异常，建议联系咪咕动漫确认 */
 	{
				var v_95_014_01_array = new Array();
				v_95_014_01_array.push(new cntCode('1','正常'));
				v_95_014_01_array.push(new cntCode('2','异常，建议联系咪咕动漫确认'));
	}
			
		
  /*2014/08/05 9:10:50 gaopeng  用户接收状态查询 查询结果 关于下发一级客服省级业务支撑系统2014年07月批次配合改造要求的通知（能力开放接口）*/
  {
  	var anim_95_005_array = new Array();
  	anim_95_005_array.push(new cntCode('0','接收异常'));
  	anim_95_005_array.push(new cntCode('1','接收正常'));
  }
  /*2014/08/05 9:10:50 gaopeng  业务补发 查询结果 关于下发一级客服省级业务支撑系统2014年07月批次配合改造要求的通知（能力开放接口）*/
  {
  	var anim_95_006_001_array = new Array();
  	anim_95_006_001_array.push(new cntCode('0','补发成功'));
  	anim_95_006_001_array.push(new cntCode('1','未开通该业务'));
  	anim_95_006_001_array.push(new cntCode('2','不能补发订购之前的彩信内容'));
  	anim_95_006_001_array.push(new cntCode('3','补发失败'));
  }
  /*2014/08/05 9:10:50 gaopeng  异常行为用户操作 操作结果 关于下发一级客服省级业务支撑系统2014年07月批次配合改造要求的通知（能力开放接口）*/
  {
  	var anim_95_007_001_array = new Array();
  	anim_95_007_001_array.push(new cntCode('0','成功'));
  	anim_95_007_001_array.push(new cntCode('1','失败'));
  	
  }
  
    {
  	var anim_95_009_001_array = new Array();
  	anim_95_009_001_array.push(new cntCode('0','送出'));
  	anim_95_009_001_array.push(new cntCode('1','获赠'));
  	
  }
  
}

//通信账户支付
{
  //商品类型编码表
  {
    var product_type_001_1_array = [];
    product_type_001_1_array.push(new cntCode('2','按次'));
    product_type_001_1_array.push(new cntCode('3','包月'));
  }
  {
  	var product_type_002_1_array = [];
  	 product_type_002_1_array.push(new cntCode('0','上行'));
  	 product_type_002_1_array.push(new cntCode('1','下行'));
	}
	{
  	var product_type_003_1_array = [];
  	 product_type_003_1_array.push(new cntCode('7','用户要求屏蔽通信账户服务'));
  	 product_type_003_1_array.push(new cntCode('8','移动要求屏蔽通信账户服务'));
	}
}

{
  //mdo计费类型
  {
    var mdo_001_jftype =new Array();
    mdo_001_jftype.push(new cntCode('1','按次计费'));
    mdo_001_jftype.push(new cntCode('2','按时长计费'));
    mdo_001_jftype.push(new cntCode('3','按月定制'));
    mdo_001_jftype.push(new cntCode('4','按限定天数定制'));
    mdo_001_jftype.push(new cntCode('5','包月定制'));
    mdo_001_jftype.push(new cntCode('9','其他'));
  }
    //mdo业务承载类型
  {
    var mdo_002_ywcztype =new Array();
    mdo_002_ywcztype.push(new cntCode('1','ivr'));
    mdo_002_ywcztype.push(new cntCode('2','wap'));
    mdo_002_ywcztype.push(new cntCode('3','web'));
    mdo_002_ywcztype.push(new cntCode('4','mms'));
    mdo_002_ywcztype.push(new cntCode('5','sms'));
    mdo_002_ywcztype.push(new cntCode('6','ivvr'));
    mdo_002_ywcztype.push(new cntCode('9','其他'));
  }
    //mdo计费状态
  {
    var mdo_002_jftype =new Array();
    mdo_002_jftype.push(new cntCode('0','计费成功'));
    mdo_002_jftype.push(new cntCode('1','计费失败'));
    mdo_002_jftype.push(new cntCode('9','未知'));
  }
}

/**  
   命名规则：j + id +第几个字段，从0开始，文档中的数字减一
*/

//手机导航
{
	//和地图订购关系履历查询
	{
    var j_44_001_2 =new Array();
    j_44_001_2.push(new cntCode('65','手机导航'));
	}
	
	{
    var j_44_001_5 =new Array();
    j_44_001_5.push(new cntCode('0','包月'));
    j_44_001_5.push(new cntCode('1','点播'));
    j_44_001_5.push(new cntCode('2','其它'));
	}
	
	{
    var j_44_001_8 =new Array();
    j_44_001_8.push(new cntCode('1','表示来自SP侧'));
    j_44_001_8.push(new cntCode('2','表示来自BOSS侧'));
    j_44_001_8.push(new cntCode('3','其他'));
	}

	{
    var j_44_001_9 =new Array();
    j_44_001_9.push(new cntCode('00','其他'));
    j_44_001_9.push(new cntCode('01','WEB'));
    j_44_001_9.push(new cntCode('02','网上营业厅'));
    j_44_001_9.push(new cntCode('03','WAP'));
    j_44_001_9.push(new cntCode('04','SMS'));
    j_44_001_9.push(new cntCode('07','1860'));
    j_44_001_9.push(new cntCode('08','营业厅'));
    j_44_001_9.push(new cntCode('09','SP'));
    j_44_001_9.push(new cntCode('80','客户端'));
	}

	{
    var j_44_001_12 =new Array();
    j_44_001_12.push(new cntCode('06','订购服务 '));
    j_44_001_12.push(new cntCode('07','退订服务'));
    j_44_001_12.push(new cntCode('99','全业务退订'));
    j_44_001_12.push(new cntCode('02','用户注销(用户状态从正常变为“销户/预销户”、“过户”、“改号”)'));
    j_44_001_12.push(new cntCode('04','用户暂停(用户欠费停机或停机保号) '));
    j_44_001_12.push(new cntCode('05','用户恢复(用户状态从停机变为复机)'));
    j_44_001_12.push(new cntCode('08','临时订购'));
	}

	{
    var j_44_001_13 =new Array();
    j_44_001_13.push(new cntCode('0','成功'));
    j_44_001_13.push(new cntCode('1','失败'));
	}
	
	{
    var j_44_001_14 =new Array();
    j_44_001_14.push(new cntCode('200','成功'));
    j_44_001_14.push(new cntCode('201','数据库操作异常'));
	}
	
	{
    var j_44_001_16 =new Array();
    j_44_001_16.push(new cntCode('1','泰为'));
    j_44_001_16.push(new cntCode('2','冠图'));
    j_44_001_16.push(new cntCode('3','高德'));
    j_44_001_16.push(new cntCode('4','灵图'));
    j_44_001_16.push(new cntCode('5','老虎宝典'));
    j_44_001_16.push(new cntCode('6','辽宁移动'));
    j_44_001_16.push(new cntCode('7','带扩展'));
	}
	
	{
    var j_44_001_17 =new Array();
    j_44_001_17.push(new cntCode('1','浏览版'));
    j_44_001_17.push(new cntCode('2','终端版'));
    j_44_001_17.push(new cntCode('3','网络版'));
    j_44_001_17.push(new cntCode('4','WAP版'));
    j_44_001_17.push(new cntCode('5','12585'));
    j_44_001_17.push(new cntCode('6','带扩展'));
	}
	
	{
    var j_44_002_2 =new Array();
    j_44_002_2.push(new cntCode('65','手机导航'));
	}
	
	{
    var j_44_002_5 =new Array();
    j_44_002_5.push(new cntCode('0','包月'));
    j_44_002_5.push(new cntCode('1','点播'));
    j_44_002_5.push(new cntCode('2','其它'));
	}
	
	{
    var j_44_002_9 =new Array();
    j_44_002_9.push(new cntCode('02','用户注销(用户状态从正常变为“销户/预销户”、“过户”、“改号”)'));
    j_44_002_9.push(new cntCode('04','用户暂停(用户欠费停机或停机保号)'));
    j_44_002_9.push(new cntCode('06','开通'));
    j_44_002_9.push(new cntCode('07','已经退订'));
    j_44_002_9.push(new cntCode('08','临时订购'));
	}

	{
    var j_44_002_10 =new Array();
    j_44_002_10.push(new cntCode('1','表示来自SP侧'));
    j_44_002_10.push(new cntCode('2','表示来自BOSS侧'));
    j_44_002_10.push(new cntCode('3','其他'));
	}

	{
    var j_44_002_11 =new Array();
    j_44_002_11.push(new cntCode('00','其他'));
    j_44_002_11.push(new cntCode('01','WEB'));
    j_44_002_11.push(new cntCode('02','网上营业厅'));
    j_44_002_11.push(new cntCode('03','WAP'));
    j_44_002_11.push(new cntCode('04','SMS'));
    j_44_002_11.push(new cntCode('07','1860'));
    j_44_002_11.push(new cntCode('08','营业厅'));
    j_44_002_11.push(new cntCode('09','SP'));
    j_44_002_11.push(new cntCode('80','客户端'));
	}

	{
    var j_44_002_14 =new Array();
    j_44_002_14.push(new cntCode('1','泰为'));
    j_44_002_14.push(new cntCode('2','冠图'));
    j_44_002_14.push(new cntCode('3','高德'));
    j_44_002_14.push(new cntCode('4','灵图'));
    j_44_002_14.push(new cntCode('5','老虎宝典'));
    j_44_002_14.push(new cntCode('6','辽宁移动'));
    j_44_002_14.push(new cntCode('7','带扩展'));
	}

	{
    var j_44_002_15 =new Array();
    j_44_002_15.push(new cntCode('1','浏览版'));
    j_44_002_15.push(new cntCode('2','终端版'));
    j_44_002_15.push(new cntCode('3','网络版'));
    j_44_002_15.push(new cntCode('4','WAP版'));
    j_44_002_15.push(new cntCode('5','12585'));
    j_44_002_15.push(new cntCode('6','带扩展'));
	}

	{
    var j_44_003_2 =new Array();
    j_44_003_2.push(new cntCode('0','订购黑名单'));
	}
}

//12582基地
{
	{
    var j_130_001_3 =new Array();
    j_130_001_3.push(new cntCode('0','订购'));
    j_130_001_3.push(new cntCode('1','退订'));
	}
	
	{
    var j_130_003_3 =new Array();
    j_130_003_3.push(new cntCode('0','短信'));
    j_130_003_3.push(new cntCode('1','彩信'));
	}
	
	{
    var j_130_003_4 =new Array();
    j_130_003_4.push(new cntCode('0','成功'));
    j_130_003_4.push(new cntCode('1','失败'));
	}
	
	{
    var j_130_004_2 =new Array();
    j_130_004_2.push(new cntCode('0','短信'));
    j_130_004_2.push(new cntCode('1','彩信'));
    j_130_004_2.push(new cntCode('2','全部'));
	}
}


//12580业务
{
	{
    var j_50_002_2 =new Array();
    j_50_002_2.push(new cntCode('0','订购'));
    j_50_002_2.push(new cntCode('1','退订'));
	}
	
	{
    var j_50_002_3 =new Array();
    j_50_002_3.push(new cntCode('0','坐席'));
    j_50_002_3.push(new cntCode('1','短信'));
    j_50_002_3.push(new cntCode('2','BOSS'));
    j_50_002_3.push(new cntCode('3','客户端渠道'));
    j_50_002_3.push(new cntCode('4','SIM卡渠道'));
    j_50_002_3.push(new cntCode('5','WAP渠道'));
    j_50_002_3.push(new cntCode('6','批开渠道'));
    j_50_002_3.push(new cntCode('7','互联网渠道'));
	}
	
	{
    var j_50_003_2 =new Array();
    j_50_003_2.push(new cntCode('0','订购'));
    j_50_003_2.push(new cntCode('1','退订'));
	}
	
	{
    var j_50_003_3 =new Array();
    j_50_003_3.push(new cntCode('0','坐席'));
    j_50_003_3.push(new cntCode('1','短信'));
    j_50_003_3.push(new cntCode('2','BOSS'));
    j_50_003_3.push(new cntCode('3','客户端渠道'));
    j_50_003_3.push(new cntCode('4','SIM卡渠道'));
    j_50_003_3.push(new cntCode('5','WAP渠道'));
    j_50_003_3.push(new cntCode('6','批开渠道'));
    j_50_003_3.push(new cntCode('7','互联网渠道'));
	}
	
}


//12590语音杂志业务
{
	{
    var j_121_001_3 =new Array();
    j_121_001_3.push(new cntCode('0','是媒体业务'));
    j_121_001_3.push(new cntCode('1','非媒体业务'));
	}
	
	{
    var j_121_002_5 =new Array();
    j_121_002_5.push(new cntCode('0','按次'));
    j_121_002_5.push(new cntCode('2','按月'));
	}
	
	{
    var j_121_002_10 =new Array();
    j_121_002_10.push(new cntCode('0','成功'));
    j_121_002_10.push(new cntCode('其他','失败'));
	}
	{
    var j_121_003_2 =new Array();
    j_121_003_2.push(new cntCode('1','免费上行'));
    j_121_003_2.push(new cntCode('2','免费下行'));
    j_121_003_2.push(new cntCode('3','计费下行'));
	}
	{
    var j_121_004_0 =new Array();
    j_121_004_0.push(new cntCode('0','已屏蔽'));
    j_121_004_0.push(new cntCode('1','未屏蔽'));
	}
	

}

{
  //卓望mdo计费类型
  {
    var zwmdo_002_jftype =new Array();
    zwmdo_002_jftype.push(new cntCode('1','按次计费'));
    zwmdo_002_jftype.push(new cntCode('2','按时长计费'));
    zwmdo_002_jftype.push(new cntCode('3','按月定制'));
    zwmdo_002_jftype.push(new cntCode('4','按限定天数定制'));
    zwmdo_002_jftype.push(new cntCode('5','包月定制'));
    zwmdo_002_jftype.push(new cntCode('9','其他'));
  }
    //mdo业务承载类型
  {
    var zwmdo_002_ywcztype =new Array();
    zwmdo_002_ywcztype.push(new cntCode('1','ivr'));
    zwmdo_002_ywcztype.push(new cntCode('2','wap'));
    zwmdo_002_ywcztype.push(new cntCode('3','web'));
    zwmdo_002_ywcztype.push(new cntCode('4','mms'));
    zwmdo_002_ywcztype.push(new cntCode('5','sms'));
    zwmdo_002_ywcztype.push(new cntCode('6','ivvr'));
    zwmdo_002_ywcztype.push(new cntCode('9','其他'));
  }
    //mdo计费状态
  {
    var zwmdo_002_jfstuts =new Array();
    zwmdo_002_jfstuts.push(new cntCode('0','计费成功'));
    zwmdo_002_jfstuts.push(new cntCode('1','计费失败'));
    zwmdo_002_jfstuts.push(new cntCode('9','未知'));
  }
}