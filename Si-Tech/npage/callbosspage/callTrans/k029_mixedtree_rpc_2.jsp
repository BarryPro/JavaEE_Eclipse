
<%
  /*
   * 功能: 来电原因填写->原因树的数据提取
　 * 版本: 1.0.0
　 * 日期: 2009/4/7
　 * 作者: jiangbing
　 * 功能说明: 分为四种情况的html生成：
　 * 1、正常的父节点点击，生成html，这种情况需要输入参数nodeId，此方法查询数据库，返回父节点为nodeId的子节点
　 * 2、初始化虚拟父节点，生成html，这种情况需要输入参数nodeId、isRoot=1、isVisual=1，此方法不查询数据库，返回虚拟父节点，虚拟节点的id=nodeId
　 * 3、初始化实体父节点，生成html，这种情况需要输入参数nodeId、isRoot=1、isVisual=0，此方法查询数据库，返回nodeId的节点
　 * 4、根据查询caption相似，来初始化列表，生成html，这种情况需要输入参数nodeId、isRoot=1、isVisual=0、caption，此方法查询数据库，返回符合条件的叶子节点html
　 * 版权: sitech
   * update:
　 */
%>
<%@ page contentType="text/html;charset=gbk"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%@ include
	file="/npage/callbosspage/callTrans/k029_mixedtree_rpc_method.jsp"%>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%
response.setHeader("Pragma", "No-cache");   
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Expires", "0"); 
String orgCode = (String)session.getAttribute("orgCode");
String regionCode = orgCode.substring(0,2);
String myParams="";
String myParams1="";
String CityCode=request.getParameter("CityCode");
//城市代码.
if(CityCode!=null){
	CityCode = CityCode.trim();
 }
String CalledNo=request.getParameter("CalledNo");
//电话号码.
if(CalledNo!=null){
	CalledNo = CalledNo.trim();
}
String UserClass=request.getParameter("UserClass");
//用户班组..从parphone里面得到.
if(UserClass!=null){
	UserClass = UserClass.trim();
}
System.out.println("CityCode from getParameter:"+CityCode);
String ServiceNo=request.getParameter("ServiceNo");
//服务号.
if(ServiceNo!=null){
	ServiceNo = ServiceNo.trim();
}
String inFlag = request.getParameter("inFlag");
String hasSelectNodes = request.getParameter("hasSelectNodes");
if(hasSelectNodes!=null){
	hasSelectNodes = hasSelectNodes.trim();
}else{
	hasSelectNodes = "";
}
String nodeId = request.getParameter("nodeId");
String isRoot = request.getParameter("isRoot");
if(isRoot==null){
	isRoot = "";
}
String nodeLevel = request.getParameter("nodeLevel");
nodeLevel = new Integer(Integer.parseInt(nodeLevel)+1).toString();
String lastChildRoute = request.getParameter("lastChildRoute");

String hasSelectOption = request.getParameter("hasSelectOption");

//下面是处理sql的.
String sqlStr = "";
StringBuffer res = new StringBuffer();

 //正常的父节点点击
if(isRoot.equals("")||isRoot.equals("0")){
//isRoot是判断是否是根节点的判断.
	if(nodeId!=null&&!nodeId.equals("")){
		if(inFlag.equals("0")){
			//如果是0 flag ,说明是业务办理.
			sqlStr=" select a.id,a.superid ,a.servicename,DECODE(a.typeid,'2001','0','1'),a.typeid,a.ttansfercode,a.digitcode, "
			+" a.userclass , a.usertype from DSCETRANSFERTAB a where 1=1 ";
			sqlStr=sqlStr+" and a.typeid<>0 and a.superid=:nodeId  order by a.id " ;
			myParams = "nodeId="+nodeId;
		}else{
			//否则就是1.是咨询语音.
			sqlStr="select a.id,a.superid ,a.servicename,DECODE(a.typeid,'2003','0','1'),a.typeid,a.transfercode,a.digitcode, "
			+" a.userclass , a.usertype from DZXSCETRANSFERTAB a where 1=1 ";
			sqlStr=sqlStr+" and a.superid=:nodeId " ;
			sqlStr=sqlStr+" order by a.id " ;
			myParams = "nodeId="+nodeId;
		}
	}
	%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="9">
		<wtc:param value="<%=sqlStr%>" />
	</wtc:service>
	<wtc:array id="resultList" start="0" length="9">
	<% 
	//	System.out.println("in k029_2rpc_3");
	for(int i = 0; i < resultList.length; i++){
		String isLast = "0";
		if( i == ( resultList.length - 1 )){//if(i == resultList.length-1){
			isLast="1";
		}
		String lastChildRoute_ = (lastChildRoute.equals("") ? lastChildRoute:( lastChildRoute+","))+isLast;
		getNodeHtml(res,resultList[i],nodeLevel,isLast,lastChildRoute_,hasSelectOption,"0",hasSelectNodes); 	
	}
	%>
	</wtc:array>
	<% 
}else{
	String isVisual = request.getParameter("isVisual");
	if(isVisual==null){
	     isVisual = "";
	}
	//初始化实体父节点
	if(isVisual.equals("") || isVisual.equals("0")){
		//added liujied
		System.out.println("in 初始化实体副节点");
		//取不到CityCode和CallNo
		System.out.println("CityCode:"+CityCode);
		System.out.println("CalledNo:"+CalledNo);
		System.out.println("UserClass:"+UserClass);
		if(!CityCode.equals("")&&!CalledNo.equals("")&&!UserClass.equals("")){
			System.out.println("in Citycode");
			if(inFlag.equals("0")){
				//如果是0 flag ,说明是业务办理.
				System.out.println("in k029_2rpc_sql_1 ");
				sqlStr="select a.id,a.superid ,a.servicename,DECODE(a.typeid,'2001','0','1'),a.typeid,a.ttansfercode, "+
				" a.digitcode,a.userclass,a.usertype from DSCETRANSFERTAB a where 1=1 ";
				sqlStr=sqlStr+"and a.accesscode=:CalledNo ";
				sqlStr=sqlStr+"and userclass=:UserClass ";
				sqlStr=sqlStr+"and citycode=:CityCode ";
				sqlStr=sqlStr+"and a.typeid not in('0','1','2','3') and not exists( select 1 from DSCETRANSFERTAB b "+
				" where b.id=a.superid) order by a.id " ;
				myParams1 = "CalledNo="+CalledNo+",UserClass="+UserClass+",CityCode="+CityCode;
			}else{
				//否则就是1.是咨询语音.
				System.out.println("in k029_2rpc_sql_2 ");
				sqlStr="select a.id,a.superid ,a.servicename,DECODE(a.typeid,'2003','0','1'),a.typeid,a.transfercode, "+ 
				"a.digitcode,a.userclass,a.usertype from DZXSCETRANSFERTAB a where 1=1 ";
				sqlStr=sqlStr+"and a.accesscode=:CalledNo ";
				sqlStr=sqlStr+"and userclass=:UserClass ";
				sqlStr=sqlStr+"and citycode=:CityCode ";
				sqlStr=sqlStr+"and not exists( select 1 from DZXSCETRANSFERTAB b where b.id=a.superid) order by a.id " ;
				myParams1 = "CalledNo="+CalledNo+",UserClass="+UserClass+",CityCode="+CityCode;
			}
		}
		%>
		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="9">
		<wtc:param value="<%=sqlStr%>"/>
		</wtc:service>
		<wtc:array id="resultList" start="0" length="9">
		<%
		for(int i = 0; i < resultList.length; i++)
		{
		     String isLast = "0";
		     if( i == ( resultList.length - 1 ))
		     {
		          isLast="1";
		     }
		     getNodeHtml(res,resultList[i],"1",isLast,isLast,hasSelectOption,"0",hasSelectNodes);
		}
		%>
		</wtc:array>
		<% 
	}else{
	    String[] param = {"0","-1","IVR","0","IVR"};
	    getNodeHtml(res,param,"1","1","1",hasSelectOption,isRoot,hasSelectNodes);
	}
}
%>
"worknos","<%=res.toString()%>") "nodeId","<%=nodeId%>")



