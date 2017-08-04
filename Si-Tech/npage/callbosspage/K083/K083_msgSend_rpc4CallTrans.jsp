<%
  /*
   * 功能: 短信发送
   * yanghy. 2009.09.08
 　*/
 %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%!//#########################添加全局函数.
/**
 * @param to_cut_str 要转换的字符串.
 * @param max_byte_size 最大的byte数.
 * @return 返回一个list 数组.
 */
public static List getArrayByByteSize(String to_cut_str, int max_byte_size){
	List list = new ArrayList();
	double str_byte_length = to_cut_str.getBytes().length ;
	//取得字符串的byte 长度.这个地方要是double类型.
	//System.out.println(str_byte_length+""+Math.round( str_byte_length / max_byte_size));
	for( double i = 0; i < Math.ceil( str_byte_length / max_byte_size ); i ++){
		//判断 要进行字符串处理几次.用double / int的结果.在取ceil.取顶.
		//将剩余字符截取.
		int cut_str_end = cutStrByByteSize(to_cut_str, max_byte_size);
		//取得开始截取的字符位置.
		list.add(to_cut_str.substring(0 , cut_str_end + 1));
		//进行数组截取.从 0 到 n
		to_cut_str = to_cut_str.substring(cut_str_end + 1);
		//返回下次累加的字符串.循环用.截取剩余字符串.从 n到最后.
		//System.out.println(to_cut_str);
	}
	return list;
}
/**
 * @param to_cut_str 要截取的字符串.
 * @param max_byte_size 需要截取的  byte 长度.
 * @return 返回截取字符串位置.
 */
private static int cutStrByByteSize(String to_cut_str, int max_byte_size) {
	int str_byte_size = 0;
	//设置字符串byte 长度.
	char[] strArray = to_cut_str.toCharArray();
	//将字符串转换成char 数组.
	for (int i = 0; i < strArray.length; i++) {
		int before_add_size = str_byte_size;
		//设置临时变量.保存上一个截取 byte 长度.
		str_byte_size += (strArray[i] + "").getBytes().length;
		if (max_byte_size > before_add_size
				&& max_byte_size < str_byte_size) {
			//这里判断如果这个在上一个byte 和这个 byte 之间.说明这个位置刚好是一个
			//汉字.这个时候返回 上一个byte. 防止字符过大.或找不到位置.
			return ( i - 1);
		} else if (str_byte_size == max_byte_size) {
			//如果位置刚好相等返回.
			return i;
		}
	}
	return to_cut_str.length() - 1;//如果没有找到返回to_cut_str.length() - 1.
}//#########################添加全局函数.
%>
<%
//短信发送需要4 个参数.
String opCode="K029";//说明是短信发送.这个是呼叫转移到Opcode.
String loginNo = (String)session.getAttribute("workNo"); 
//得到要发送的电话.在呼叫转移里面只是一个电话.
String user_phone = (String)request.getParameter("user_phone");
String[] msg_content = request.getParameterValues("msg_content");
//得到发送短信的数组.这个是多个.
String scucc_flag = "1";
//判断手机号码位数.

try{
	if(msg_content != null){//如果内容为空不发送.
		for(int i = 0; i < msg_content.length; i ++){//如果内容为空不发送.
			if(msg_content[i] != null && !msg_content[i].equals("") ){
				//判断短信内容是否为空.
				
				List list = getArrayByByteSize(msg_content[i],250);
				for(int j = 0; j < list.size(); j ++){
					System.out.println(i+"###############"+list.get(j));
					/**old sql :String logSql =
					" insert into sms_push_rec_log (serial_no,user_phone,serv_no,insert_time,send_content,success_flag,send_login_no, serv_code) "
					+" select to_char(sysdate,'yyyymmdd')||lpad(SEQ_SMS_PUSH_REC.nextval,10,'0'),'"+user_phone+"','10086',sysdate,'"
					+list.get(j).toString()//短信日志.
					+"','1','"+loginNo+"' ,'"+opCode+"' from  dual";//opcCode添加到serv_code字段里面.
					*/
					String orgCode = (String)session.getAttribute("orgCode");
					String regionCode = orgCode.substring(0,2);
					String logSql = " insert into sms_push_rec_log (serial_no,user_phone,serv_no,insert_time,send_content,success_flag,send_login_no, serv_code) "
						+" select to_char(sysdate,'yyyymmdd')||lpad(SEQ_SMS_PUSH_REC.nextval,10,'0'), :v1,'10086',sysdate, :v2,'1', :v3 , :v4 from  dual";
					System.out.println("######################################");
					System.out.println(list.get(j).toString());
					System.out.println(opCode);
					System.out.println(loginNo);
					System.out.println(user_phone);
					System.out.println("######################################");
					//新添加日志。%>
					<wtc:service name="sPubModifyKfCfm" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
						<wtc:param value="<%=logSql%>"/>
						<wtc:param value="dbchange"/>
						<wtc:param value="<%=user_phone%>"/>
						<wtc:param value="<%=list.get(j).toString()%>"/>
						<wtc:param value="<%=loginNo%>"/>
						<wtc:param value="<%=opCode%>"/>
					 </wtc:service>
					 
					<wtc:service name="sK083InsertNew" outnum="2">
						<wtc:param value="<%=list.get(j).toString()%>" />
						<wtc:param value="<%=opCode%>" />
						<wtc:param value="<%=loginNo%>" />
						<wtc:param value="<%=user_phone%>"/>
					</wtc:service>
					<wtc:array id="retList" scope="end" />
				<%}
				System.out.println("retList=");
			}
		}	
	}//如果没有错误返回1正常.
	System.out.println("发送短信成功.");
	out.print("1");//直接输出..
}catch(Exception e){
	out.print("-1");//直接输出..
}%>