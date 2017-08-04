<%
/********************
 version v2.0
开发商: si-tech
修改人	修改时间	修改原因
niuhr 2009/11/12	集团配置功能改造
********************/
%>     
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=gbk"%>
<%if ((request.getCharacterEncoding() == null))
      {request.setCharacterEncoding("GBK");}%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.Vector" %>
<%@ page import="java.util.List"%>
<%@ page import="com.sitech.channelmng.PrdMgrSql" %>
<%@ page import="sitech.www.frame.jdbc.PageVo" %>
<%@ page import="sitech.www.frame.jdbc.SqlQuery" %>

<%
		String opCode = "3522";
		String opName = "用户类型与附加字段代码对应表";
		
		String loginNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
		String loginName = WtcUtil.repNull((String)session.getAttribute("workName"));
		String orgCode = WtcUtil.repNull((String)session.getAttribute("orgCode"));   
		String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
		String ip_Addr = WtcUtil.repNull((String)session.getAttribute("ipAddr"));
		String loginNoPass = WtcUtil.repNull((String)session.getAttribute("password"));
		String  powerCode= (String)session.getAttribute("powerCode");

		  //分页1
		int rowCount =0;
		int pageSize=50;            //每页行数
		int pageCount=0;              //总的页数
		int curPage=1;                //当前页
		//需要参数传递
		int beginPos;               //结果集中数据的起始位置
		int endPos;                 //结果集中数据的终止位置
		String strPage;             //作为参数传过来的页
		String sSqlCondition="";
		List list=null;
		
		String sqlStr = "";
		String busiType = "";
		String userType = "";
		String fieldCode = "";
		String ctrlInfo = "";
		String fieldOrder = "";//add
		String fieldDefvalue = "";//add
		String grpCode = "";//newadd
		String openParamFlag = "";//newadd
		String updateFlag = "";//newadd
	
		int que_flag = 1;
		int add_flag=1;
		
		Vector vTemp=null;
		PrdMgrSql sqlSrvCmd=new PrdMgrSql();
		
		boolean bUserExist=false;
		List sqlList = new ArrayList();
		String myaction=request.getParameter("myaction");
		int len1 =0;
		int len2= 0;
		String srvname = "sPubSelect";

   try {
					busiType    = WtcUtil.repNull(request.getParameter("busiType")  );
					userType    = WtcUtil.repNull(request.getParameter("userType")  );
					fieldCode   = WtcUtil.repNull(request.getParameter("fieldCode") );
					ctrlInfo    = WtcUtil.repNull(request.getParameter("ctrlInfo")  );
					fieldOrder  = WtcUtil.repNull(request.getParameter("fieldOrder"));
					fieldDefvalue = WtcUtil.repNull(request.getParameter("fieldDefvalue")  );
					grpCode       = WtcUtil.repNull(request.getParameter("grpCode")        );//newadd
					openParamFlag = WtcUtil.repNull(request.getParameter("openParamFlag")  );
					updateFlag    = WtcUtil.repNull(request.getParameter("updateFlag")     );	 
					//新增角色
					if ("add_user".equals(myaction)) {
							busiType    = WtcUtil.repNull(request.getParameter("busiType")  );
							userType    = WtcUtil.repNull(request.getParameter("userType")  );
							fieldCode   = WtcUtil.repNull(request.getParameter("fieldCode") );
							ctrlInfo    = WtcUtil.repNull(request.getParameter("ctrlInfo")  );
							fieldOrder  = WtcUtil.repNull(request.getParameter("fieldOrder"));
							fieldDefvalue = WtcUtil.repNull(request.getParameter("fieldDefvalue")  );
							grpCode       = WtcUtil.repNull(request.getParameter("grpCode")        );//newadd
							openParamFlag = WtcUtil.repNull(request.getParameter("openParamFlag")  );
							updateFlag    = WtcUtil.repNull(request.getParameter("updateFlag")     );	 

		        if (busiType==null||busiType.trim().length()==0)
		        {
		            System.out.println("请添入完整的信息！");
		        }
		        else
		        {
							sqlStr="SELECT count(*) FROM sUserTypeFieldRela where busi_type='"+busiType+"' and user_type='"+userType+"' and field_code='"+fieldCode+"'";
							int listNum=sqlSrvCmd.functionBindOneInt(sqlStr);
						if(listNum!=0)
						{
						    System.out.println("The code has existed!");
						    bUserExist=true;
						}
						else
						{			
							sqlStr = "insert into sUserTypeFieldRela (busi_type,user_type,field_code,field_order,ctrl_info,field_defvalue,field_grp_no,OPEN_PARAM_FLAG,UPDATE_FLAG) values('"+busiType+"','"+
							          userType+"','" +
							          fieldCode+"','" +
							          fieldOrder+"','"+
							          ctrlInfo+"','"+
												fieldDefvalue+"','"+
												grpCode+"','"+
												openParamFlag+"','"+
												updateFlag+"')";
								    
							sqlList.add(sqlStr);		
			        int flag=sqlSrvCmd.updateTrsaction(sqlList);
				if(flag==1){
				%>
				<script>
				rdShowMessageDialog("新增成功！",2)
				</script>
				<%
				}
				else{
				%>
				<script>
				rdShowMessageDialog("新增失败！",0)
				</script>
				<%
				}               				
            }
        }
    }

    //删除角色
    if ("del_sm".equals(myaction)) {
				String busi_type = request.getParameter("busi_type");
				String[] sArrTemp= com.sitech.common.BaseToolsClass.splitStringToArray(busi_type,";");
				System.out.println(sArrTemp.length);
				for(int i=0;i<sArrTemp.length;i++){      
						String[] primaryDelete=com.sitech.common.BaseToolsClass.splitStringToArray(sArrTemp[i],",");
						sqlStr = "delete from sUserTypeFieldRela where busi_type = "+primaryDelete[0]+"' and user_type='"+primaryDelete[1]+"' and field_code='"+primaryDelete[2];
						sqlList.add(sqlStr);
		}				
		int flag=sqlSrvCmd.updateTrsaction(sqlList);
		if(flag==1){
	%>
			<script>
				rdShowMessageDialog("删除成功！",2)
			</script>
	<%
		}
		else{
	%>
			<script>
				rdShowMessageDialog("删除失败！",0)
			</script>
	<%
		}
	}

    //查询角色
    if ("doLoad".equals(myaction)) {
		     
		    busiType  =WtcUtil.repNull( request.getParameter("busiType") );       
				userType  =WtcUtil.repNull( request.getParameter("userType") );
		    fieldCode =WtcUtil.repNull( request.getParameter("fieldCode"));
				ctrlInfo  =WtcUtil.repNull( request.getParameter("ctrlInfo") );
				grpCode   =WtcUtil.repNull( request.getParameter("grpCode")  );
		//openParamFlag = request.getParameter("openParamFlag");
	 	//updateFlag = request.getParameter("updateFlag");
	 	
	 	System.out.println("busiTypebusiTypebusiTypebusiType==="+busiType);
		
        if(busiType.trim().length()!=0)
        {
            sSqlCondition="and busi_type like '%"+busiType+"%'";
        }
        if(userType.trim().length()!=0)
        {
            sSqlCondition=sSqlCondition+"and user_type like '%"+userType+"%'";
        }
		    if(fieldCode.trim().length()!=0)
        {
            sSqlCondition=sSqlCondition+"and field_code like '%"+fieldCode+"%'";
        }
        if(grpCode.trim().length()!=0)//newadd
        {
            sSqlCondition=sSqlCondition+"and field_grp_no like '%"+grpCode+"%'";
        }
        
        sqlStr = "select busi_type,user_type,field_code,ctrl_info,field_order,field_defvalue,field_grp_no ,OPEN_PARAM_FLAG,UPDATE_FLAG from sUserTypeFieldRela where 1=1 "+sSqlCondition+" order by busi_type";
        que_flag = 2;

    }


if(que_flag==1){
        //初始、链接进入；新增、删除
        //分页2
        rowCount = sqlSrvCmd.functionBindOneInt ("SELECT count(*)  from sUserTypeFieldRela");
        strPage = request.getParameter("page");
        if (strPage==null||strPage.equals("")||strPage.trim().length()==0){
          curPage=1;
        }else{
            curPage=Integer.parseInt(strPage);
          if(curPage<1) curPage=1;
        }
        pageCount=(rowCount+pageSize-1)/pageSize;
        if (curPage>pageCount) curPage=pageCount;
        beginPos=(curPage-1)*pageSize+1;
        endPos=beginPos+pageSize-1;
        if(endPos>rowCount) endPos=rowCount;

        PageVo pv=sqlSrvCmd.queryBindPageVo("select busi_type,user_type,field_code,ctrl_info,field_order,field_defvalue,field_grp_no,OPEN_PARAM_FLAG,UPDATE_FLAG from sUserTypeFieldRela order by busi_type",beginPos,endPos);
        list = pv.getList();

		System.out.println("初始进入");
    }
    else
    {
        //点击查询、翻页按钮进入
        //分页2'
		//System.out.println("next page.....................curPage"+curPage);
        rowCount = sqlSrvCmd.functionBindOneInt ("SELECT count(*)  FROM sUserTypeFieldRela where 1=1 "+sSqlCondition);//szy
        strPage = request.getParameter("page");
        if (strPage==null||strPage.equals("")||strPage.trim().length()==0){
          curPage=1;
        }else{
            curPage=Integer.parseInt(strPage);
          if(curPage<1) curPage=1;
        }
        pageCount=(rowCount+pageSize-1)/pageSize;
        if (curPage>pageCount) curPage=pageCount;
        beginPos=(curPage-1)*pageSize+1;
        endPos=beginPos+pageSize-1;
        if(endPos>rowCount) endPos=rowCount;

        //条件查询
        PageVo pv2=sqlSrvCmd.queryBindPageVo(sqlStr,beginPos,endPos);
        list = pv2.getList();

    }


    }catch (Exception ex) {
        ex.printStackTrace();
    }
	String strSqlbusi;
	String  strbusi = " select busi_type ,busi_name from suserbusitype order by busi_type ";
	if(busiType.trim().length()!=0)
        {
            strSqlbusi="  and busi_type = "+busiType;
        }
    else{
    		strSqlbusi="  where 1 = 1";
    	
    	}
	String  strsm = " SELECT a.sm_code ,b.sm_name FROM sbusitypesmcode a ,ssmcode b  where a.sm_code = b.sm_code  and b.region_code = "+regionCode ;
	
%>


<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="2">
		<wtc:sql><%=strsm%> </wtc:sql>
</wtc:pubselect>
<wtc:array id="rows2" scope="end"/>
<%			
	if(retCode.equals("000000"))
	{	
		for(int i=0;i<rows2.length;i++)
		{
             //System.out.println("rows["+i+"][0]"+rows[i][0]);
             //System.out.println("rows["+i+"][1]"+rows[i][1]);
		}	
        len2=rows2.length;
	}
	else{
%>    
		<script language=javascript>	
			rdShowMessageDialog("查询用户类型出错！!",0);
			document.location.replace("<%=request.getContextPath()%>/npage/s3522/s3522.jsp");
		</script>
<%
	}		
%>	

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=opName%></title>
<META content="text/html; charset=gbk" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">
<script language=javascript>

function getFieldCode(){
	if(document.sp_form.busiType.value=='')
	{
     rdShowMessageDialog("请选择一个业务类型！",1)
    }
    else
	var a=window.showModalDialog("getFieldCode.jsp?busiType="+document.sp_form.busiType.value,window,"dialogHeight:700px;dialogWidth:600px;");
}


function getGrpNo()
{
	
	if(document.sp_form.userType.value==''){
     rdShowMessageDialog("请选择一个用户类型！",1)
    }
  else
	{
		var a=window.showModalDialog("getGrp_No.jsp?userType="+document.sp_form.userType.value,window);
	}
}

function checkTable()
{
	if(trim(document.sp_form.busiType.value).length==0){
	     rdShowMessageDialog("业务类型不能为空！",1)
	     sp_form.busiType.focus();
	     return false;
	 }
	if(document.sp_form.userType.value==''){
	     rdShowMessageDialog("请选择一个用户类型！",1)
	     return false;
		}
	 if(trim(document.sp_form.fieldCode.value).length==0){
	     rdShowMessageDialog("字段代码不能为空！",1)
	     sp_form.fieldCode.focus();
	     return false;
	 }
	  /*if(trim(document.sp_form.ctrlInfo.value).length==0){
	     rdShowMessageDialog("控制信息不能为空！",1)
	     sp_form.ctrlInfo.focus();
	     return false;
	     
	 }*/
	  if(trim(document.sp_form.fieldOrder.value).length==0){
	     rdShowMessageDialog("字段序号不能为空！",1)
	     sp_form.fieldOrder.focus();
	     return false;
	 }
	  /*if(trim(document.sp_form.fieldDefvalue.value).length==0){
	     rdShowMessageDialog("默认值不能为空！",1)
	     sp_form.fieldDefvalue.focus();
	     return false;
	 }*/
	 if(trim(document.sp_form.grpCode.value).length==0){ 
	
	     rdShowMessageDialog("表单组号不能为空！",1)
	     sp_form.fieldDefvalue.focus();
	     return false;
	 }
 	return true;
}
//分页3
 function doLoad(operateCode)
 {
    if(operateCode=="load")
    {
      window.sp_form.page.value="";
    }
    else if(operateCode=="first")
    {
      window.sp_form.page.value=1;
    }
    else if(operateCode=="pre")
    {
      window.sp_form.page.value=<%=(curPage-1)%>;
    }
    else if(operateCode=="next")
    {
      window.sp_form.page.value=<%=(curPage+1)%>;
    }
    else if(operateCode=="last")
    {
      window.sp_form.page.value=<%=pageCount%>;
    }
      window.sp_form.myaction.value="doLoad";
      window.sp_form.action="s3522.jsp";
      window.sp_form.method='post';
      window.sp_form.submit();

 }

function doSelectAll()
{
  var form = document.sp_form ;
  var p = 0;
  var ilength = parseInt(form.chkBoxNum.value);
  for (i=0; i<ilength;i++ )
  {
    if (eval('form.ChkBoxDelete_'+i).checked == true)
    {
      p = p +1;
    }
  }
  if (p==ilength)
  {
     for (i=0; i<ilength;i++ )
     {
        eval('form.ChkBoxDelete_'+i).checked = false ;
     }
  }
  else
  {
     for (i=0; i<ilength;i++ )
     {
        eval('form.ChkBoxDelete_'+i).checked = true ;
     }
  }

}
function doDelete( )
{
  var form = document.sp_form ;
  var ilength = parseInt(form.chkBoxNum.value);
  var szIdList="";
  var p=0;

  for(i=0;i<ilength;i++)
  {
    if(eval('form.ChkBoxDelete_'+i).checked)
    {
      szIdList=szIdList+"'"+eval('form.ChkBoxDelete_'+i).value+"';";
      p++;
    }
  }

  if(p<=0)
  {
    rdShowMessageDialog("请选择要删除的记录！",1)
    return;
  }

  szIdList=szIdList.substring(0,szIdList.length-1);


if(confirm('是否删除？'))

	location.href='s3522.jsp?myaction=del_sm&busi_type='+szIdList;


}

function submitInputAdd(url)
{
	if(checkTable()){
		submitMe(url);
	}
	else return;
}
function submitInput(url){
    submitMe(url);
}
function submitMe(url){
    if(url.substring(url.length-8)=="add_user"){
          window.sp_form.action=url;
          window.sp_form.method='post';
          window.sp_form.submit();
    }
    else{

          window.sp_form.action=url;
          window.sp_form.method='post';
          window.sp_form.submit();

    }
}
//截掉字符串前后空格
function trim(arg)
{
  if(arg.length==0)
  {
    return '';
  }

    //定位第一个非空格位置
  for(var i=0;i<arg.length;i++)
  {
    var onechar=arg.charAt(i);
    if(onechar!=' ')
    {
      break;
    }
  }
  arg=arg.substring(i,arg.length);

    if(arg.length==0)
  {
    return '';
  }

    //定位第一个非空格位置(逆向搜索)
  for(var i=arg.length;i>0;i--)
  {
    var onechar=arg.charAt(i-1);
    if(onechar!=' ')
    {
      break;
    }
  }
  arg=arg.substring(0,i);
  return arg;
}
function clearForm(){
	var e = document.forms[0].elements;
	for(var i=0;i<e.length;i++){
  		if(e[i].type=="select-one"||e[i].type=="text")
   		e[i].value="";
 }
}


/*function busiTypeChange()
{
	if(document.sp_form.busiType.value).length==0)
	//if (document.sp_form.busiType.value.equals(""))
	{
		//document.sp_form.BUserType.disabled = false;
		document.sp_form.userType.value="";
	}
	else
	{
		//document.sp_form.BUserType.disabled = true;
		document.sp_form.userType.value="xxxx";
	}
}*/
function chgUserType(obj){
    var vSmCode = obj.value;
    
    var packet = new AJAXPacket("getBusiType.jsp","请稍后...");
    packet.data.add("smCode" ,vSmCode);
    core.ajax.sendPacket(packet,doChgUserType,true);
    packet =null;
}

function doChgUserType(packet){
    var retCode = packet.data.findValueByName("retCode"); 
    var retMsg = packet.data.findValueByName("retMessage");
    var vBusiType = packet.data.findValueByName("busiType");
    var vBusiName = packet.data.findValueByName("busiName");
    
    if(retCode == "000000"){
        if(vBusiType != ""){
            $("#busiType").val(vBusiType);
            $("#busiName").val(vBusiType+"-"+vBusiName);
        }else{
            rdShowMessageDialog("没有对应的业务类型！",0);
        return false;
        }
    }else{
        rdShowMessageDialog("查询业务类型失败！错误代码："+retCode+",错误信息："+retMsg,0);
        return false;
    }
}
</SCRIPT>
</HEAD>
<BODY>
<FORM name="sp_form" method="post" >
<%@ include file="/npage/include/header.jsp" %> 
	<div class="title">
		<div id="title_zi"> 用户类型与附加字段代码对应表 </div>
	</div>

        <table cellspacing="0">
           <tr>
               <td class="blue">用户类型</td>
               <td>
               	  <SELECT name="userType" id="userType" onChange="chgUserType(this)">
					<option value="">---请选择---</option>
    	             	<% for(int i = 0; i < len2; i++){%>
    	               	 	<option value="<%=rows2[i][0].trim()%>"><%=rows2[i][0].trim()%>&nbsp;-&gt&nbsp;<%=rows2[i][1].trim()%></option>
						<%}%>
				</select>
			   </td>
			   
               <td class="blue">业务类型</td>
               <td>
				<input type='text' id='busiName' name='busiName' value='' readOnly />
				<input type='hidden' id='busiType' name='busiType' value=''/>
			   </td>
               
			   
               <!--<td><input name="userType" type="text" class="button" id="userType" maxlength="4" value='<%=(userType==null)?"":userType%>' readonly>
			   <input class="b_text" name="BUserType" type="button" onClick="getUserType()" value="查询">
			   </td>-->
           </tr>
           
           
           <tr>
             <td class="blue">字段代码</td>
			 <td><input name="fieldCode" type="text" class="button" id="fieldCode" maxlength="5" readOnly value='<%=(fieldCode==null)?"":fieldCode%>'>
			 <input class="b_text" type="button" onClick="getFieldCode()" value="查询"></td>
			 <td class="blue">控制信息</td>
			 <td><input name="ctrlInfo" type="text" class="button" id="ctrlInfo" maxlength="5" value='<%=(ctrlInfo==null)?"":ctrlInfo%>'></td>
           </tr>
           
           
		   <tr >
             <td class="blue">字段序号</td>
			 <td><input name="fieldOrder" type="text" class="button" id="fieldOrder" maxlength="5" value='<%=(fieldOrder==null)?"":fieldOrder%>'></td>
			 <td class="blue">默认值</td>
			 <td><input name="fieldDefvalue" type="text" class="button" id="fieldDefvalue" maxlength="5" value='<%=(fieldDefvalue==null)?"":fieldDefvalue%>'></td>             
           </tr>
           
           <tr>
             <td class="blue">表单组号</td>
			       <td><input name="grpCode" type="text" class="button" id="grpCode" maxlength="5" value='<%=(grpCode==null)?"":grpCode%>' readonly>
			       <input class="b_text" type="button" onClick="getGrpNo()" value="查询"></td>		       	
				<td class="blue">是否存属性</td>
               	<td>
				  <select name="openParamFlag">
				  	<option>---请选择---</option>
					<option value="Y" <%=(openParamFlag!=null&&openParamFlag.equals("Y"))?"selected":""%>>Y--存储属性</option>
					<option value="N" <%=(openParamFlag!=null&&openParamFlag.equals("N"))?"selected":""%>>N--不存储属性</option>
				  </select>
			   	</td>
			</tr>
			<tr>
				<td class="blue">是否可修改</td>
				<td colspan="3">
					<select name="updateFlag">	
						<option>---请选择---</option>	
						<option value="Y" <%=(updateFlag!=null&&updateFlag.equals("Y"))?"selected":""%>>Y--是</option>
						<option value="N" <%=(updateFlag!=null&&updateFlag.equals("N"))?"selected":""%>>N--否</option>					
					</select>
			</td>
 
     </table>
		<TABLE cellSpacing="0" >
			<TR id='footer'>
				<TD id="footer" align="center">          	                    	           	              	                          	
        	        <input name="add_user" class="b_foot" type="button" id="add_user"   onClick="submitInputAdd('s3522.jsp?myaction=add_user')" value="新增">
        	        <input name="bat_del_user" class="b_foot" type="button" id="bat_del_user"   onClick="doDelete();return false;" value="删除">
					<input name="que_user" class="b_foot" type="button" id="que_user"        onClick="doLoad('load');return false;" value="查询">
					<input name="d" type="button" class="b_foot"  onClick="javascript:clearForm()" value="清空">
					<input name="back" type="button" class="b_foot" onClick="removeCurrentTab();"  value="关闭">
			    </td>
			</tr>
			<tr>
        	        <%if ("add_user".equals(myaction)&& bUserExist){%>
					<script language="javascript">
						 rdShowMessageDialog("该代码已经存在",0)
					</script>
        	        <%}%>
			</tr>
       </table>
        <table cellspacing="0" >
        	<input type="hidden" name="chkBoxNum"  value="<%=list.size()%>">
        	<tr>
       			<td class="blue" align="center"><strong><div><font color="green"><a href="" onClick="doSelectAll();return false;">全选</font></a></div></TD>
                     <TH class="blue" align="center"><div>业务类型</div></TH>
                     <TH class="blue" align="center"><div>用户类型</div></TH>
                     <TH class="blue" align="center"><div>字段代码</div></TH>
					 <TH class="blue" align="center"><div>控制信息</div></TH>					 
            </tr>
                   <% for (int i=0;i<list.size();i++) { %>
                   <% String[] array = (String[]) list.get(i);%>
					<%if (i%2==0){%>
                   <tr>
					<%} else{%>
				   <tr>
					<%}%>
                     <td align="center">
                       <input type="checkbox" name="ChkBoxDelete_<%=i%>" value="<%=array[0].trim()+","+array[1].trim()+","+array[2].trim()%>" >
                     </td>
                     <td align="center"> <a href=" s3522_m.jsp?busiType=<%=array[0]%>&userType=<%=array[1]%>&fieldCode=<%=array[2]%>&ctrlInfo=<%=array[3]%>&fieldOrder=<%=array[4]%>&fieldDefvalue=<%=array[5]%>&grpCode=<%=array[6]%>&openParamFlag=<%=array[7]%>&updateFlag=<%=array[8]%> " > <%=array[0]%> </a> </td>
                     <td align="center"> <%=array[1]%> </td>
                     <td align="center"><%=array[2]%></td>
					 <td align="center"><%=(array[3]==null)?"":array[3]%></td>                    
                   </tr>
                   <% } %>
          </table>
<!--//分页4-->
        <table cellspacing="0" >
		<input type="hidden" name="page" value="">
		<input type="hidden" name="myaction" value="">
		<input type="hidden" name="modeType" value="">

    <tr >
            <td class="listformbottom"  height="35" align="right" width="720">
              <%if(pageCount!=0){%>
              第 <%=curPage%>页 共 <%=pageCount%>页 共 <%=rowCount%>条
              <%} else{%>
              <font color="red">当前记录为空！</font>
              <%}%>
              <%if(pageCount!=1 && pageCount!=0){%>
              <a href="#" onClick="doLoad('first');return false;">首页</a>
              <%}%>
              <%if(curPage>1){%>
              <a href="#" onClick="doLoad('pre');return false;">上一页</a>
              <%}%>
              <%if(curPage<pageCount){%>
              <a href="#" onClick="doLoad('next');return false;">下一页</a>
              <%}%>
              <%if(pageCount>1){%>
              <a href="#" onClick="doLoad('last');return false;">尾页</a>
              <%}%>
            </td>

    </tr>
  </table>

	 <%@ include file="/npage/include/footer.jsp" %>  
   </FORM>
<script LANGUAGE=javascript>
//busiTypeChange();
//userTypeChange()
</script>
  </BODY>
 </HTML>
