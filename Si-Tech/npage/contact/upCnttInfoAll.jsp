<%
/*
接触记录程序
shibc
20080701

还需要完成的工作：
TODO:查询用户id所属的客户，如果一致则记录 否则新接触
TODO:session失效的时候关闭最后一次接触

使用方式：
String url = "/npage/contact/upCnttInfo.jsp?opCode=1302&opName=缴费&workNo=shibc&retCodeForCntt=000000&loginAccept=1111&pageActivePhone=&contactId=13330002323&contactType=user";
<jsp:include page=url flush="true" />

由于徐伟要求，增加参数组织传入：
retMsgForCntt :服务返回信息
opBeginTime：业务服务开始时间

传入参数：
opCode：操作代码
opName：操作名称
workNo：操作员
retCodeForCntt：服务返回值
loginAccept ：服务返回流水
pageActivePhone ：二级tab打开时，传入手机号码
contactType ：接触主体类型 user cust acc grp
contactId：接触主体id
优先级：
activePhone(session)>pageActivePhone(request)>contactId,contactType(request)
*/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ page import="java.util.*"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %> 
<%
	String opCode = request.getParameter("opCode")==null?"":request.getParameter("opCode");
	String opName = request.getParameter("opName")==null?"":request.getParameter("opName");
	String workNo = request.getParameter("workNo")==null?"":request.getParameter("workNo");
	String retCodeForCntt = request.getParameter("retCodeForCntt")==null?"":request.getParameter("retCodeForCntt");
	String retMsgForCntt = request.getParameter("retMsgForCntt")==null?"":request.getParameter("retMsgForCntt");	
	String opBeginTime = request.getParameter("opBeginTime")==null?"":request.getParameter("opBeginTime");
	String loginAccept = request.getParameter("loginAccept")==null?"":request.getParameter("loginAccept");
	
  if(retCodeForCntt.equals("000000"))retMsgForCntt="SUCCESS";

	retCodeForCntt=retCodeForCntt+"#"+retMsgForCntt;
	
	//接触平台状态
  String appCnttFlag = (String)application.getAttribute("appCnttFlag"); 
  if("Y".equals(appCnttFlag)){
%>

<%
//获取流水号
if(loginAccept==null||"".equals(loginAccept)||"null".equals(loginAccept.toLowerCase())){
%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept"  id="cnttLoginAccept"/>
<%
	loginAccept=cnttLoginAccept;
}
	//初始化当前session信息 记录当前的接触id和类型
	
	//包含用户(手机号码)，帐户，客户
	String _lastCurrentContactType = (String)session.getAttribute("_lastCurrentContactType");
	if(_lastCurrentContactType==null) _lastCurrentContactType="init";
	//相关类型的id
	String _lastCurrentContactId = (String)session.getAttribute("_lastCurrentContactId");
	if(_lastCurrentContactId==null) _lastCurrentContactId="init";
	
	//初始化开始信息 从配置信息获取数据
	String _sessionActivePhone = (String)session.getAttribute("activePhone");//当前有些的激活号码
	String _pageActivePhone = request.getParameter("pageActivePhone");//从用户工作区激活的一级tab
  //System.out.println("_pageActivePhone==="+_pageActivePhone);
	
	//静态初始化配置信息 需要修改 需要opCode声明 不采用配置，修改成参数传入
	//contactType (用户user 客户 cust 帐户 acc 集团 grp) 
	//contactId 对应的接触主体的号码id

	String _pageContactId = request.getParameter("contactId");
	//从request获取接触id，用户user 客户 cust 帐户 acc
	//0-客户，1-用户，2-帐户，3-集团客户标识

	String _contactIdType = request.getParameter("contactType");
	if(_contactIdType==null||_contactIdType.equals(""))
	{
		_contactIdType="1";
	}else if(_contactIdType.equals("user"))
	{
		_contactIdType="1";
	}else if(_contactIdType.equals("cust"))
	{
		_contactIdType="0";
	}else if(_contactIdType.equals("acc"))
	{
		_contactIdType="2";
	}else if(_contactIdType.equals("grp"))
	{
		_contactIdType="3";
	}else
	{
		_contactIdType="1";
	}

	//当前的接触类别和id
	String _currentContactType = null;
	String _currentContactId = null;
	
	//是否使用新的接触类别替换旧的，替换不能出现信息的降级和丢失
	boolean _replaceFlag = true;
	//是否是新接触
	boolean _isNewContact = true;
	//是否记录接触信息
	boolean _isRecord = true;
	
	//上一次接触流水, （即接触ID --liubo）
	String _lastContactSeq = (String)session.getAttribute("_lastContactSeq");
	System.out.println("_lastContactSeq=="+_lastContactSeq);

	if(_sessionActivePhone!=null&&!_sessionActivePhone.equals("")) 
	{
		_currentContactId = _sessionActivePhone;
		_currentContactType = "1";
	}
	else if(_pageActivePhone!=null&&!_pageActivePhone.equals("")) 
	{ 
		_currentContactId = _pageActivePhone;
		_currentContactType = "1";
	}
	else if(_pageContactId!=null&&!_pageContactId.equals("")) 
	{
		_currentContactId = _pageContactId;
		_currentContactType = _contactIdType;
	}
	else
	{
		//无法获取接触信息
		_currentContactId = "";
		_currentContactType = "";
	}
	
	//开始进行融合判断
	if(_currentContactId.equals(""))
	{
			//当前接触值不合法，则直接跳出
			_replaceFlag=true;
			_isNewContact=true;
			_isRecord=false;
	}
	else
	{
		if(_currentContactType.equals("1"))
		{
			//记录用户信息
	
			if(_lastCurrentContactType.equals("1"))
			{
				if(_currentContactId.equals(_lastCurrentContactId))
				{
					//记录接触信息
					_replaceFlag=false;
					_isNewContact=false;
					_isRecord=true;
				}
				else
				{
					//记录接触信息
					_replaceFlag=true;
					_isNewContact=true;
					_isRecord=true;
				}
			}else if(_lastCurrentContactType.equals("0"))
			{
					_replaceFlag=true;
					_isNewContact=true;
					_isRecord=true;
			
			}else if(_lastCurrentContactType.equals("2"))
			{
					//启动新接触
					_replaceFlag=true;
					_isNewContact=true;
					_isRecord=true;
					
			}else
			{
			   //启动新接触
					_replaceFlag=true;
					_isNewContact=true;
					_isRecord=true;
			}
	
			
		}else if(_currentContactType.equals("0"))
		{
			//记录客户信息
			if(_lastCurrentContactType.equals("1"))
			{
				//TODO:查询用户id所属的客户，如果一致则记录 否则新接触
				
					_replaceFlag=true;
					_isNewContact=true;
					_isRecord=true;
					//-------- begin of 开始判断客户和用户相关性 ------------------------------
					try{
%>
	<wtc:pubselect name="sPubSelect" outnum="1">
		<wtc:sql> select cust_id from dcustmsg where phone_no='?' </wtc:sql>
	  <wtc:param value="<%=_currentContactId%>"/> 
	</wtc:pubselect>
	<wtc:array id="rows"  scope="end"/>
<%
	  	if(!retCode.equals("000000")){
				System.out.println("sPubSelect查询错误："+retCode);
		   }
		   else
		   {
		   	if(rows.length==1)
		   	{
		   	  if(rows[0].length==1)
		   	  {
			   		if(rows[0][0]!=null&&!rows[0][0].equals(""))
			   		{
			   			if(rows[0][0].equals(_lastCurrentContactId))
			   			{
			   				//继承原来的接触
								_replaceFlag=false;
								_isNewContact=false;
								_isRecord=true;
			   			}
			   		}
			   	}
		   	}
		   }
			}catch(Throwable e)
			{
				e.printStackTrace();
			}
					//-------------end of 开始判断客户和用户相关性 ------------------------
				
			}else if(_lastCurrentContactType.equals("0"))
			{
	
				if(_currentContactId.equals(_lastCurrentContactId))
				{
					//记录接触信息
					_replaceFlag=false;
					_isNewContact=false;
					_isRecord=true;
				}
				else
				{
					//记录接触信息
					_replaceFlag=true;
					_isNewContact=true;
					_isRecord=true;
				}
			
			}else if(_lastCurrentContactType.equals("2"))
			{
					//启动新接触
					_replaceFlag=true;
					_isNewContact=true;
					_isRecord=true;
					
			}else
			{
			   //启动新接触
					_replaceFlag=true;
					_isNewContact=true;
					_isRecord=true;
			}

		}else if(_currentContactType.equals("2"))
		{
			//记录帐户接触信息
			if(_lastCurrentContactType.equals("1"))
			{
					_replaceFlag=true;
					_isNewContact=true;
					_isRecord=true;
				
			}else if(_lastCurrentContactType.equals("0"))
			{
			   //启动新接触
					_replaceFlag=true;
					_isNewContact=true;
					_isRecord=true;
			
			}else if(_lastCurrentContactType.equals("2"))
			{
	
				if(_currentContactId.equals(_lastCurrentContactId))
				{
					//记录接触信息
					_replaceFlag=false;
					_isNewContact=false;
					_isRecord=true;
				}
				else
				{
					//记录接触信息
					_replaceFlag=true;
					_isNewContact=true;
					_isRecord=true;
				}
					
			}else
			{
			   //启动新接触
					_replaceFlag=true;
					_isNewContact=true;
					_isRecord=true;
			}
			
		}else
		{
			//不记录接触信息
					_replaceFlag=true;
					_isNewContact=true;
					_isRecord=false;
		}
	}

System.out.println("--------begin 接触信息 ----------");
System.out.println("--------_replaceFlag ----------"+_replaceFlag);
System.out.println("--------_isNewContact ----------"+_isNewContact);
System.out.println("--------_isRecord ----------"+_isRecord);
System.out.println("--------end 接触信息----------");

//开始记录接触信息
if(_isRecord)
{
	if(_isNewContact)
	{
		//新接触开始 关闭上一次，开启本次接触
		if(!_lastCurrentContactType.equals("init"))
		{
			//TODO:session失效的时候关闭最后一次接触
			//----------------------------------------begin of 关闭上次接触---------------------------------------
			
			if(_lastContactSeq!=null)
			{
			try{
%>
				<wtc:service name="sEndCntt"  outnum="1">
				<wtc:param value="<%=_lastContactSeq%>"/>
				<wtc:param value="<%=_currentContactId%>"/>
				</wtc:service>
				<wtc:array id="rows"  scope="end"/>
<%

		  	if(!retCode.equals("000000")){
					System.out.println("sEndCntt记录接触错误:"+retCode);
			   }
				}catch(Throwable e)
				{
				
				}
			}
			//----------------------------------------end of 关闭上次接触-----------------------------------------
		}
		
		//------------------------------------begin of 记录当前接触----------------------------------------------
    //接触平台状态
    try{
		%>
		    <wtc:service name="sInitCntt"  outnum="1">
			    <wtc:param value=""/>
			    <wtc:param value=""/>
					<wtc:param value=""/>
					<wtc:param value=""/>
					<wtc:param value="<%=_currentContactType%>"/>
					<wtc:param value="<%=_currentContactId%>"/>
					<wtc:param value="01"/>
					<wtc:param value="00"/>
					<wtc:param value="i"/>
					<wtc:param value="<%=workNo%>"/>
					<wtc:param value=""/>
					<wtc:param value=""/>
					<wtc:param value=""/>
					<wtc:param value=""/>		
					<wtc:param value=""/>			
		    </wtc:service>
		    <wtc:array id="rows"  scope="end"/>
		<%   
		  	if(retCode.equals("000000")){
		  		//设置上一次接触流水
		     	 session.setAttribute("_lastContactSeq",rows[0][0]);
			   }
			   else
			   {
			   	System.out.println("sInitCntt记录接触错误:"+retCode);
			   }
	    }catch(Throwable e)
	    {
	    }
		//------------------------------------end of 记录当前接触---------------------------------------
		
	}

		System.out.println("--------_lastContactSeq流水:"+session.getAttribute("_lastContactSeq"));
		_lastContactSeq = (String)session.getAttribute("_lastContactSeq");

		//-------------------------------------begin of 记录当前业务接触----------------------------
		try{
			%>	
				<wtc:service name="sUpCnttInfo" outnum="0">
					<wtc:param value="<%=_lastContactSeq%>" />
					<wtc:param value="" />
					<wtc:param value="" />
					<wtc:param value="<%=opCode%>" />
					<wtc:param value="<%=opName%>" />
					<wtc:param value="<%=loginAccept%>" />
					<wtc:param value="<%=retCodeForCntt%>" />
					<wtc:param value="<%=_currentContactId%>" />
					<wtc:param value="<%=_pageActivePhone%>" />
					<wtc:param value="<%=opBeginTime%>" />
				</wtc:service>
				<wtc:array id="rows"  scope="end"/>
			<%
				if(!retCode.equals("000000")){
					System.out.println("sUpCnttInfo记录接触错误:"+retCode);
			   }
	    }catch(Throwable e)
	    {
	    }
		//-------------------------------------end of 记录当前业务接触 ---------------------------- 

}

//替换旧的接触信息
if(_replaceFlag)
{
	session.setAttribute("_lastCurrentContactType",_currentContactType);
	session.setAttribute("_lastCurrentContactId",_currentContactId);
}

}
%>
