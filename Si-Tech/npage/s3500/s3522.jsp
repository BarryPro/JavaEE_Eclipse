<%
/********************
 version v2.0
������: si-tech
�޸���	�޸�ʱ��	�޸�ԭ��
niuhr 2009/11/12	�������ù��ܸ���
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
		String opName = "�û������븽���ֶδ����Ӧ��";
		
		String loginNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
		String loginName = WtcUtil.repNull((String)session.getAttribute("workName"));
		String orgCode = WtcUtil.repNull((String)session.getAttribute("orgCode"));   
		String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
		String ip_Addr = WtcUtil.repNull((String)session.getAttribute("ipAddr"));
		String loginNoPass = WtcUtil.repNull((String)session.getAttribute("password"));
		String  powerCode= (String)session.getAttribute("powerCode");

		  //��ҳ1
		int rowCount =0;
		int pageSize=50;            //ÿҳ����
		int pageCount=0;              //�ܵ�ҳ��
		int curPage=1;                //��ǰҳ
		//��Ҫ��������
		int beginPos;               //����������ݵ���ʼλ��
		int endPos;                 //����������ݵ���ֹλ��
		String strPage;             //��Ϊ������������ҳ
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
					//������ɫ
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
		            System.out.println("��������������Ϣ��");
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
				rdShowMessageDialog("�����ɹ���",2)
				</script>
				<%
				}
				else{
				%>
				<script>
				rdShowMessageDialog("����ʧ�ܣ�",0)
				</script>
				<%
				}               				
            }
        }
    }

    //ɾ����ɫ
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
				rdShowMessageDialog("ɾ���ɹ���",2)
			</script>
	<%
		}
		else{
	%>
			<script>
				rdShowMessageDialog("ɾ��ʧ�ܣ�",0)
			</script>
	<%
		}
	}

    //��ѯ��ɫ
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
        //��ʼ�����ӽ��룻������ɾ��
        //��ҳ2
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

		System.out.println("��ʼ����");
    }
    else
    {
        //�����ѯ����ҳ��ť����
        //��ҳ2'
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

        //������ѯ
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
			rdShowMessageDialog("��ѯ�û����ͳ���!",0);
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
     rdShowMessageDialog("��ѡ��һ��ҵ�����ͣ�",1)
    }
    else
	var a=window.showModalDialog("getFieldCode.jsp?busiType="+document.sp_form.busiType.value,window,"dialogHeight:700px;dialogWidth:600px;");
}


function getGrpNo()
{
	
	if(document.sp_form.userType.value==''){
     rdShowMessageDialog("��ѡ��һ���û����ͣ�",1)
    }
  else
	{
		var a=window.showModalDialog("getGrp_No.jsp?userType="+document.sp_form.userType.value,window);
	}
}

function checkTable()
{
	if(trim(document.sp_form.busiType.value).length==0){
	     rdShowMessageDialog("ҵ�����Ͳ���Ϊ�գ�",1)
	     sp_form.busiType.focus();
	     return false;
	 }
	if(document.sp_form.userType.value==''){
	     rdShowMessageDialog("��ѡ��һ���û����ͣ�",1)
	     return false;
		}
	 if(trim(document.sp_form.fieldCode.value).length==0){
	     rdShowMessageDialog("�ֶδ��벻��Ϊ�գ�",1)
	     sp_form.fieldCode.focus();
	     return false;
	 }
	  /*if(trim(document.sp_form.ctrlInfo.value).length==0){
	     rdShowMessageDialog("������Ϣ����Ϊ�գ�",1)
	     sp_form.ctrlInfo.focus();
	     return false;
	     
	 }*/
	  if(trim(document.sp_form.fieldOrder.value).length==0){
	     rdShowMessageDialog("�ֶ���Ų���Ϊ�գ�",1)
	     sp_form.fieldOrder.focus();
	     return false;
	 }
	  /*if(trim(document.sp_form.fieldDefvalue.value).length==0){
	     rdShowMessageDialog("Ĭ��ֵ����Ϊ�գ�",1)
	     sp_form.fieldDefvalue.focus();
	     return false;
	 }*/
	 if(trim(document.sp_form.grpCode.value).length==0){ 
	
	     rdShowMessageDialog("����Ų���Ϊ�գ�",1)
	     sp_form.fieldDefvalue.focus();
	     return false;
	 }
 	return true;
}
//��ҳ3
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
    rdShowMessageDialog("��ѡ��Ҫɾ���ļ�¼��",1)
    return;
  }

  szIdList=szIdList.substring(0,szIdList.length-1);


if(confirm('�Ƿ�ɾ����'))

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
//�ص��ַ���ǰ��ո�
function trim(arg)
{
  if(arg.length==0)
  {
    return '';
  }

    //��λ��һ���ǿո�λ��
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

    //��λ��һ���ǿո�λ��(��������)
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
    
    var packet = new AJAXPacket("getBusiType.jsp","���Ժ�...");
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
            rdShowMessageDialog("û�ж�Ӧ��ҵ�����ͣ�",0);
        return false;
        }
    }else{
        rdShowMessageDialog("��ѯҵ������ʧ�ܣ�������룺"+retCode+",������Ϣ��"+retMsg,0);
        return false;
    }
}
</SCRIPT>
</HEAD>
<BODY>
<FORM name="sp_form" method="post" >
<%@ include file="/npage/include/header.jsp" %> 
	<div class="title">
		<div id="title_zi"> �û������븽���ֶδ����Ӧ�� </div>
	</div>

        <table cellspacing="0">
           <tr>
               <td class="blue">�û�����</td>
               <td>
               	  <SELECT name="userType" id="userType" onChange="chgUserType(this)">
					<option value="">---��ѡ��---</option>
    	             	<% for(int i = 0; i < len2; i++){%>
    	               	 	<option value="<%=rows2[i][0].trim()%>"><%=rows2[i][0].trim()%>&nbsp;-&gt&nbsp;<%=rows2[i][1].trim()%></option>
						<%}%>
				</select>
			   </td>
			   
               <td class="blue">ҵ������</td>
               <td>
				<input type='text' id='busiName' name='busiName' value='' readOnly />
				<input type='hidden' id='busiType' name='busiType' value=''/>
			   </td>
               
			   
               <!--<td><input name="userType" type="text" class="button" id="userType" maxlength="4" value='<%=(userType==null)?"":userType%>' readonly>
			   <input class="b_text" name="BUserType" type="button" onClick="getUserType()" value="��ѯ">
			   </td>-->
           </tr>
           
           
           <tr>
             <td class="blue">�ֶδ���</td>
			 <td><input name="fieldCode" type="text" class="button" id="fieldCode" maxlength="5" readOnly value='<%=(fieldCode==null)?"":fieldCode%>'>
			 <input class="b_text" type="button" onClick="getFieldCode()" value="��ѯ"></td>
			 <td class="blue">������Ϣ</td>
			 <td><input name="ctrlInfo" type="text" class="button" id="ctrlInfo" maxlength="5" value='<%=(ctrlInfo==null)?"":ctrlInfo%>'></td>
           </tr>
           
           
		   <tr >
             <td class="blue">�ֶ����</td>
			 <td><input name="fieldOrder" type="text" class="button" id="fieldOrder" maxlength="5" value='<%=(fieldOrder==null)?"":fieldOrder%>'></td>
			 <td class="blue">Ĭ��ֵ</td>
			 <td><input name="fieldDefvalue" type="text" class="button" id="fieldDefvalue" maxlength="5" value='<%=(fieldDefvalue==null)?"":fieldDefvalue%>'></td>             
           </tr>
           
           <tr>
             <td class="blue">�����</td>
			       <td><input name="grpCode" type="text" class="button" id="grpCode" maxlength="5" value='<%=(grpCode==null)?"":grpCode%>' readonly>
			       <input class="b_text" type="button" onClick="getGrpNo()" value="��ѯ"></td>		       	
				<td class="blue">�Ƿ������</td>
               	<td>
				  <select name="openParamFlag">
				  	<option>---��ѡ��---</option>
					<option value="Y" <%=(openParamFlag!=null&&openParamFlag.equals("Y"))?"selected":""%>>Y--�洢����</option>
					<option value="N" <%=(openParamFlag!=null&&openParamFlag.equals("N"))?"selected":""%>>N--���洢����</option>
				  </select>
			   	</td>
			</tr>
			<tr>
				<td class="blue">�Ƿ���޸�</td>
				<td colspan="3">
					<select name="updateFlag">	
						<option>---��ѡ��---</option>	
						<option value="Y" <%=(updateFlag!=null&&updateFlag.equals("Y"))?"selected":""%>>Y--��</option>
						<option value="N" <%=(updateFlag!=null&&updateFlag.equals("N"))?"selected":""%>>N--��</option>					
					</select>
			</td>
 
     </table>
		<TABLE cellSpacing="0" >
			<TR id='footer'>
				<TD id="footer" align="center">          	                    	           	              	                          	
        	        <input name="add_user" class="b_foot" type="button" id="add_user"   onClick="submitInputAdd('s3522.jsp?myaction=add_user')" value="����">
        	        <input name="bat_del_user" class="b_foot" type="button" id="bat_del_user"   onClick="doDelete();return false;" value="ɾ��">
					<input name="que_user" class="b_foot" type="button" id="que_user"        onClick="doLoad('load');return false;" value="��ѯ">
					<input name="d" type="button" class="b_foot"  onClick="javascript:clearForm()" value="���">
					<input name="back" type="button" class="b_foot" onClick="removeCurrentTab();"  value="�ر�">
			    </td>
			</tr>
			<tr>
        	        <%if ("add_user".equals(myaction)&& bUserExist){%>
					<script language="javascript">
						 rdShowMessageDialog("�ô����Ѿ�����",0)
					</script>
        	        <%}%>
			</tr>
       </table>
        <table cellspacing="0" >
        	<input type="hidden" name="chkBoxNum"  value="<%=list.size()%>">
        	<tr>
       			<td class="blue" align="center"><strong><div><font color="green"><a href="" onClick="doSelectAll();return false;">ȫѡ</font></a></div></TD>
                     <TH class="blue" align="center"><div>ҵ������</div></TH>
                     <TH class="blue" align="center"><div>�û�����</div></TH>
                     <TH class="blue" align="center"><div>�ֶδ���</div></TH>
					 <TH class="blue" align="center"><div>������Ϣ</div></TH>					 
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
<!--//��ҳ4-->
        <table cellspacing="0" >
		<input type="hidden" name="page" value="">
		<input type="hidden" name="myaction" value="">
		<input type="hidden" name="modeType" value="">

    <tr >
            <td class="listformbottom"  height="35" align="right" width="720">
              <%if(pageCount!=0){%>
              �� <%=curPage%>ҳ �� <%=pageCount%>ҳ �� <%=rowCount%>��
              <%} else{%>
              <font color="red">��ǰ��¼Ϊ�գ�</font>
              <%}%>
              <%if(pageCount!=1 && pageCount!=0){%>
              <a href="#" onClick="doLoad('first');return false;">��ҳ</a>
              <%}%>
              <%if(curPage>1){%>
              <a href="#" onClick="doLoad('pre');return false;">��һҳ</a>
              <%}%>
              <%if(curPage<pageCount){%>
              <a href="#" onClick="doLoad('next');return false;">��һҳ</a>
              <%}%>
              <%if(pageCount>1){%>
              <a href="#" onClick="doLoad('last');return false;">βҳ</a>
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
