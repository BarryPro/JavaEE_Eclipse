<%
/********************
 version v2.0
������: si-tech
* �޸�����      �޸���      �޸�Ŀ��
* 2009/11/12	niuhr		�������ù��ܸ���
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=gbk"%>

<%if ((request.getCharacterEncoding() == null))
      {request.setCharacterEncoding("GBK");}%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.Vector" %>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="com.sitech.channelmng.PrdMgrSql" %>
<%@ page import="sitech.www.frame.jdbc.PageVo" %>
<%@ page import="sitech.www.frame.jdbc.SqlQuery" %>


<%
		
	String opCode = "3520";
	String opName = "�û������ֶα�";
	List sqlList = new ArrayList();		
	String loginNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
    String loginName = WtcUtil.repNull((String)session.getAttribute("workName"));
    String orgCode = WtcUtil.repNull((String)session.getAttribute("orgCode"));   
    String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
	String ip_Addr = WtcUtil.repNull((String)session.getAttribute("ipAddr"));
	String loginNoPass = WtcUtil.repNull((String)session.getAttribute("password"));
	String  powerCode= (String)session.getAttribute("powerCode");
	String strDate=new SimpleDateFormat("yyyyMMddHHmmss").format(Calendar.getInstance().getTime());
		
	    
	//���й���Ȩ�޼���
    int rowCount =0;
    int pageSize=10;            //ÿҳ����
    int pageCount =0;              //�ܵ�ҳ��
    int curPage =0;                //��ǰҳ
    //��Ҫ��������
	int beginPos;               //����������ݵ���ʼλ��
    int endPos;                 //����������ݵ���ֹλ��
    String strPage;             //��Ϊ������������ҳ
	String sSqlCondition="";
    List list=null;
    String sqlStr = "";

    String busiType = "";
    String fieldCode = "";
    String fieldName = "";
	String fieldPurpose="";
    String fieldType = "";
	String fieldLength = "";
	String fieldNote = "";

    int que_flag = 1;

     Vector vTemp=null;
     PrdMgrSql sqlSrvCode=new PrdMgrSql();
     boolean bUserExist=false;
     
     String action=request.getParameter("action");
     String  strbusi = " select busi_type ,busi_name from suserbusitype order by busi_type ";
     int len1 =0;
     

   try {
		/*//�޸ķ������
		if("modify_user".equals(action)){
		String cm =
	    }*/
        busiType = request.getParameter("busiType");
        fieldCode = request.getParameter("fieldCode");
        fieldName = request.getParameter("fieldName");
		fieldPurpose = request.getParameter("fieldPurpose");
		fieldType = request.getParameter("fieldType");
		fieldLength = request.getParameter("fieldLength");
		fieldNote = request.getParameter("fieldNote");
    //������ɫ
    if ("add_user".equals(action)) 
    {
        busiType = request.getParameter("busiType");
        fieldCode = request.getParameter("fieldCode");
        fieldName = request.getParameter("fieldName");
		fieldPurpose = request.getParameter("fieldPurpose");
		fieldType = request.getParameter("fieldType");
		fieldLength = request.getParameter("fieldLength");
		fieldNote = request.getParameter("fieldNote");
        if (fieldCode==null||fieldCode.trim().length()==0)
        {
            System.out.println("��������������Ϣ��");
        }
        else
        {
            sqlStr="SELECT count(*) FROM sUserFieldCode where busi_type = '"+busiType+"' and field_code='"+fieldCode+"'";
			int listNum=sqlSrvCode.functionBindOneInt(sqlStr);
            if(listNum!=0)
            {
                System.out.println("The code has existed!");
                bUserExist=true;
            }
            else
            {
                sqlStr = "insert into sUserFieldCode (busi_type,field_code,field_name,field_purpose,field_type,field_length,field_note) values('"+busiType+"','"+fieldCode+"','"+
						 fieldName+"','" +
						 fieldPurpose+"','"+
						 fieldType+"','" +
                         fieldLength+"','"+
						 fieldNote+"')";
				sqlList.add(sqlStr);				 
                int flag=sqlSrvCode.updateTrsaction(sqlList);
				if(flag==1){
				%>
				<script>
				rdShowMessageDialog("�����ɹ���",2)
				clearForm()
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
    if ("del_sm".equals(action)) {
        fieldCode = request.getParameter("fieldCode");
		String[] sArrTemp= com.sitech.common.BaseToolsClass.splitStringToArray(fieldCode,";");
        for(int i=0;i<sArrTemp.length;i++)
        {
            String[] primaryDelete=com.sitech.common.BaseToolsClass.splitStringToArray(sArrTemp[i],",");
	        sqlStr = "delete from sUserFieldCode where busi_type = '"+primaryDelete[0] + "' and field_code = '" + primaryDelete[1] + "'";
			sqlList.add(sqlStr);
		}
		fieldCode="";
                int flag=sqlSrvCode.updateTrsaction(sqlList);
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
    if ("que_user".equals(action)) {
        busiType = request.getParameter("busiType");
        fieldCode = request.getParameter("fieldCode");
        fieldName = request.getParameter("fieldName");
		fieldPurpose = request.getParameter("fieldPurpose");
		fieldType = request.getParameter("fieldType");
        fieldLength = request.getParameter("fieldLength");
		fieldNote = request.getParameter("fieldNote");
		System.out.println("in que_user");
        if(busiType.trim().length()!=0)
        {
            sSqlCondition="and busi_type like '%"+busiType+"%'";
        }
        if(fieldCode.trim().length()!=0)
        {
            sSqlCondition=sSqlCondition+"and field_code like '%"+fieldCode+"%'";
        }
		if(fieldName.trim().length()!=0){
		    sSqlCondition=sSqlCondition+"and field_name like '%"+fieldName+"%'";
		}
		if(fieldPurpose.trim().length()!=0){
		    sSqlCondition=sSqlCondition+"and field_purpose like '%"+fieldPurpose+"%'";
		}
		if(fieldType.trim().length()!=0){
		    sSqlCondition=sSqlCondition+"and field_type like '%"+fieldType+"%'";
		}
        if(fieldLength.trim().length()!=0){
		    sSqlCondition=sSqlCondition+"and field_length like '%"+fieldLength+"%'";
		}
          sqlStr = "select  busi_type,field_code,field_name,field_purpose,field_type,field_length,field_note from sUserFieldCode where 1=1 "+sSqlCondition+" order by busi_type,field_code";
		  System.out.println("sqlStr="+sqlStr);

        //�����ѯ����ҳ��ť����
        //��ҳ2'
        rowCount = sqlSrvCode.functionBindOneInt ("SELECT count(*)  FROM sUserFieldCode a where 1=1 "+sSqlCondition);
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
        PageVo pv2=sqlSrvCode.queryBindPageVo("select  busi_type,field_code,field_name,field_purpose,field_type,field_length,field_note from sUserFieldCode where 1=1 "+sSqlCondition,beginPos,endPos);
        list = pv2.getList();
		//System.out.println("�ǳ�ʼ����");
		que_flag = 2;
    }
    if("fanye".equals(action))
    {        
	    busiType = request.getParameter("busiType");
	    fieldCode = request.getParameter("fieldCode");
        fieldName = request.getParameter("fieldName");
		fieldPurpose = request.getParameter("fieldPurpose"); 
		fieldType = request.getParameter("fieldType");
        fieldLength = request.getParameter("fieldLength");
		
		fieldNote = request.getParameter("fieldNote");
		
        if(busiType.trim().length()!=0)
        {
            sSqlCondition="and busi_type like '%"+busiType+"%'";
        }
        if(fieldCode.trim().length()!=0)
        {
            sSqlCondition=sSqlCondition+"and field_code like '%"+fieldCode+"%'";
        }
		if(fieldName.trim().length()!=0){
		    sSqlCondition=sSqlCondition+"and field_name like '%"+fieldName+"%'";
		}
		if(fieldPurpose.trim().length()!=0){
		    sSqlCondition=sSqlCondition+"and field_purpose like '%"+fieldPurpose+"%'";
		}
		if(fieldType.trim().length()!=0){
		    sSqlCondition=sSqlCondition+"and field_type like '%"+fieldType+"%'";
		}
        if(fieldLength.trim().length()!=0){
		    sSqlCondition=sSqlCondition+"and field_length like '%"+fieldLength+"%'";
		}
		
        //�����ѯ����ҳ��ť����
        //��ҳ2'
        rowCount = sqlSrvCode.functionBindOneInt ("SELECT count(*)  FROM sUserFieldCode a where 1=1 "+sSqlCondition);
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
        PageVo pv2=sqlSrvCode.queryBindPageVo("select  busi_type,field_code,field_name,field_purpose,field_type,field_length,field_note from sUserFieldCode where 1=1 "+sSqlCondition+ "order by busi_type,field_code",beginPos,endPos);
        list = pv2.getList();
		que_flag = 2;
    }

    if(que_flag==1){
	//��ѯȫ��
 //��ʼ�����ӽ��룻������ɾ��
        //��ҳ2
        rowCount = sqlSrvCode.functionBindOneInt ("SELECT count(*)  FROM sUserFieldCode a where 1=1 ");
		
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
        	
        PageVo pv=sqlSrvCode.queryBindPageVo("select  busi_type,field_code,field_name,field_purpose,field_type,field_length,field_note from sUserFieldCode where 1=1 order by busi_type,field_code",beginPos,endPos);
		list = pv.getList();

		System.out.println("��ʼ����");
    }


    }catch (Exception ex) {
        ex.printStackTrace();
    }
%>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="2">
		<wtc:sql><%=strbusi%> </wtc:sql>
</wtc:pubselect>
<wtc:array id="rows1" scope="end"/>
	
<%			
	if(retCode.equals("000000"))
	{	
		for(int i=0;i<rows1.length;i++)
		{
             //System.out.println("rows["+i+"][0]"+rows[i][0]);
             //System.out.println("rows["+i+"][1]"+rows[i][1]);
		}	
        len1=rows1.length;
	}
	else{
%>    
		<script language=javascript>	
			rdShowMessageDialog("��ѯҵ��������Ϣ����!",0);
			/* document.location.replace("<%=request.getContextPath()%>/npage/s5630/f5630_1.jsp"); */
			removeCurrentTab();
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

  function checkDate(theDate)
  {
	var chars= "0123456789";
	var tempDate=trim(theDate);
	if(tempDate.length!=10)
	{
		rdShowMessageDialog("������Ϸ������ڣ�",0)
		return false;
	}
	var year=tempDate.substring(0,4);
	var month=tempDate.substring(5,7);
	var day=tempDate.substring(8,10);
	
	if(tempDate.substring(4,5)!="-"||tempDate.substring(7,8)!="-")
	{
		rdShowMessageDialog("������Ϸ������ڣ�",0)
		return false;
	}
    var tempDate2=year+month+day;
	for(var i=0;i<=tempDate2.length;i++)
	{
		if(chars.indexOf(tempDate2.charAt(i))==-1){
		rdShowMessageDialog("������Ϸ������ڣ�",0)
		return false;
		}
	}
    if(!js_checkBirthday(year,month,day))
    {
		return false;
    }
        return true;
  }

  function js_checkBirthday(y1,m1,d1)
  {
    //У������������Ƿ�Ϸ�
    //alert("y,m,d="+y1+","+m1+","+d1);
    var y=parseInt(y1,10);
    var m=parseInt(m1,10);
    var d=parseInt(d1,10);
    //alert("y,m,d="+y+","+m+","+d);
    if(m<1||m>12)
    {
      rdShowMessageDialog("��������ȷ���·ݣ�",0)
      return false;
    }

    if ( m==4 || m==6 || m==9 || m==11 )
    {
      if (d<1||d>30)
      {
        rdShowMessageDialog("��������ȷ�����ڣ�",0)
        return false;
      }
    }
    else if ( m==02 )
    {
      if ( ((y % 4)==0) && ((y % 100)!=0) || ((y % 400)==0) )
      {
        if ( d<1 || d>29 )
        {
          rdShowMessageDialog("��������ȷ�����ڣ�",0)
          return false;
        }
      }
      else
      {
        if ( d<1 || d>28 )
        {
          rdShowMessageDialog("��������ȷ�����ڣ�",0)
          return false;
        }
      }
    }
    else
    {
      if ( d<1 || d>31 )
      {
        rdShowMessageDialog("��������ȷ�����ڣ�",0)
        return false;
      }
    }
    if(y<1900||y>2100)
    {
      rdShowMessageDialog("��������Ч����ݣ�",0)
      return false;
    }
    return true;
  }
  /********************�Ƚ����ڴ�С**********************/
  function compareDate(){
    var d = new Date();
	var s1=""
    var sDate = d.getDate();
	var sDate1 ="";
	if(sDate<10)
 	    sDate1 = "-0"+sDate;
	else
		sDate1 = "-"+sDate;
	var sMonth = d.getMonth()+1;
	if(sMonth<10)
	    sMonth = "-0"+sMonth;
	else
		sMonth = "-"+sMonth;
	s1 += d.getYear()+sMonth + sDate1;
	//startDate��endDateΪ���������
	if(cm_form.beginTime.value < s1){
		rdShowMessageDialog("��ʼ���ڲ������ڽ���",1)
		cm_form.beginTime.focus();
		return false;
	}
	if(trim(cm_form.beginTime.value)>trim(cm_form.endTime.value) || trim(cm_form.beginTime.value) == trim(cm_form.endTime.value)){
		rdShowMessageDialog("��ʼ�����ڽ�������֮ǰ",1)
		cm_form.endTime.focus();
		return false;
	}
	return true;
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

function checkTable()
{
	var beginDate;
	var endDate;
	if(trim(document.cm_form.fieldCode.value).length==0){
     rdShowMessageDialog("�ֶδ��벻��Ϊ�գ�",1)
     cm_form.fieldCode.focus();
     return false;
 }
 
     if(trim(document.cm_form.fieldCode.value).length!=5){
     rdShowMessageDialog("�ֶδ���Ϊ��λ��",1)
     cm_form.fieldCode.focus();
     return false;
 }
 
 if(trim(document.cm_form.fieldName.value).length==0){
     rdShowMessageDialog("�ֶδ������Ʋ���Ϊ�գ�",1)
     cm_form.fieldName.focus();
     return false;
 }
 if(trim(document.cm_form.fieldPurpose.value).length==0){
     rdShowMessageDialog("�ֶ���;����Ϊ�գ�",1)
     cm_form.fieldPurpose.focus();
     return false;
 }
 if(trim(document.cm_form.fieldLength.value).length==0){
     rdShowMessageDialog("�ֶ���󳤶ȱ�����д��",1)
     cm_form.fieldPurpose.focus();fieldType
     return false;
 }
 if(trim(document.cm_form.fieldType.value).length==0){
     rdShowMessageDialog("�ֶ����ͱ���ѡ��",1)
     cm_form.fieldPurpose.focus();
     return false;
 }
 return true;
}
//��ҳ3
 function doLoad(operateCode){
    if(operateCode=="load")
    {
      window.cm_form.page.value="";
    }
    else if(operateCode=="first")
    {
      window.cm_form.page.value=1;
    }
    else if(operateCode=="pre")
    {
      window.cm_form.page.value=<%=(curPage-1)%>;
    }
    else if(operateCode=="next")
    {
      window.cm_form.page.value=<%=(curPage+1)%>;
    }
    else if(operateCode=="last")
    {
      window.cm_form.page.value=<%=pageCount%>;
    }
      window.cm_form.myaction.value="doLoad";
      window.cm_form.action="s3520.jsp?action=fanye";
      window.cm_form.method='post';
      window.cm_form.submit();

 }

function doSelectAll()
{
	var form = document.cm_form ;
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
	var form = document.cm_form ;
	var ilength = parseInt(form.chkBoxNum.value);
	var szIdList="";
	var p=0;
	
	for(i=0;i<ilength;i++)
	{
		if(eval('form.ChkBoxDelete_'+i).checked)
		{
			szIdList=szIdList+eval('form.ChkBoxDelete_'+i).value+";";
			p++;
		}
	}
	
	if(p<=0)
	{
		alert("��ѡ��Ҫɾ���ļ�¼��");
		return;
	}
	
	szIdList=szIdList.substring(0,szIdList.length-1);
	
	//alert(szIdList);
	if(confirm('�Ƿ�ɾ����'))
	
	location.href='s3520.jsp?action=del_sm&fieldCode='+szIdList;


}
function submitInputAdd(url)
{
	if(checkTable())
	{
		submitMe(url);
	}
	else return;
}
function submitInput(url)
{
    submitMe(url);
}
function submitMe(url){
    if(url.substring(url.length-8)=="add_user")
    {

          window.cm_form.action=url;
          window.cm_form.method='post';
          window.cm_form.submit();
    }
    else{
          window.cm_form.action=url;
          window.cm_form.method='post';
          window.cm_form.submit();
    }
}

function changeServiceName()
{
	document.all.serviceName.value=document.all.cmType.value;
}

function clearForm()
{
	var e = document.forms[0].elements;
	for(var i=0;i<e.length;i++)
	{
  		if(e[i].type=="select-one"||e[i].type=="text")
   		e[i].value="";
//  alert(e[i].value);
	}
}

</SCRIPT>
</HEAD>
<BODY>
<FORM METHOD=POST name="cm_form"> 
<%@ include file="/npage/include/header.jsp" %> 
	<div class="title">
		<div id="title_zi" >�û������ֶδ����</div>
	</div>

        <table  cellspacing="0" >
           <tr>
               <td class="blue">ҵ�����Ͷ���</td>
               <td colspan="3">
               	<!-- <SELECT name="busiType" id="busiType">
               	  	<option value="1000" <%=(busiType!=null&&busiType.equals("1000"))?"selected":""%>>1000--IDCҵ��</option> 
               	  </SELECT>
               </td>
             <td> -->              
               	  <SELECT name="busiType" id="busiType">
    	             	<% for(int i = 0; i < len1; i++){%>
    	               	 	<option value="<%=rows1[i][0].trim()%>"><%=rows1[i][0].trim()%>&nbsp;-&gt&nbsp;<%=rows1[i][1].trim()%></option>
						<%}%>
				</select>
				<font color="orange">*</font>
			   </td>
           </tr>
           <tr>
               <td class="blue">�ֶδ���</td>
				<TD>
               		<input name="fieldCode" type="text" class="button" id="fieldCode"  maxlength="5"  value="<%=(fieldCode==null)?"":fieldCode%>" >
               		<font color="orange">*</font>
				</TD>
               <td class="blue">�ֶδ�������</td>
               <td>
                  <input name="fieldName" type="text" class="button" id="fieldName" maxlength="20" value="<%=(fieldName==null)?"":fieldName%>" >
                  <font color="orange">*</font>
			   </td>
           </tr>
           <tr>
				<td class="blue">�ֶ���;</td>
               	<td>
				  <select name="fieldPurpose">
				    <option></option>
					<option value="10" <%=(fieldPurpose!=null&&fieldPurpose.equals("10"))?"selected":""%>>10--���ô���</option>
					<option value="11" <%=(fieldPurpose!=null&&fieldPurpose.equals("11"))?"selected":""%>>11--����</option>
					<option value="12" <%=(fieldPurpose!=null&&fieldPurpose.equals("12"))?"selected":""%>>12--��ʹ�÷�</option>
				  </select>
				  <font color="orange">*</font>
			   	</td>
				<td class="blue">�ֶ�����</td>
				<td>
					<select name="fieldType">
						<option></option>			
						<option value="10" <%=(fieldType!=null&&fieldType.equals("10"))?"selected":""%>>10--����</option>
						<option value="11" <%=(fieldType!=null&&fieldType.equals("11"))?"selected":""%>>11--������</option>
						<option value="12" <%=(fieldType!=null&&fieldType.equals("12"))?"selected":""%>>12--�ַ���</option>
						<option value="13" <%=(fieldType!=null&&fieldType.equals("13"))?"selected":""%>>13--���'XXXX.YY'</option>
						<option value="14" <%=(fieldType!=null&&fieldType.equals("14"))?"selected":""%>>14--������'YYYYMMDD'</option>
						<option value="15" <%=(fieldType!=null&&fieldType.equals("15"))?"selected":""%>>15--������ʱ����'YYYYMMDD HH24:MI:SS'</option>
						<option value="16" <%=(fieldType!=null&&fieldType.equals("16"))?"selected":""%>>16--BOOL��</option>
						<option value="17" <%=(fieldType!=null&&fieldType.equals("17"))?"selected":""%>>17--�̶��б�</option>
						<option value="18" <%=(fieldType!=null&&fieldType.equals("18"))?"selected":""%>>18--����</option>
						<option value="19" <%=(fieldType!=null&&fieldType.equals("19"))?"selected":""%>>19--�ɹ�ʽ��������</option>
					</select>
					<font color="orange">*</font>
				</td>
           </tr>
		   <tr>
				<td class="blue">�ֶ���󳤶�</td>
				<td>
					<input name="fieldLength" type="text" class="button" id="fieldLength" maxlength="8" value="<%=(fieldLength==null)?"":fieldLength%>" >
				    <font color="orange">*</font>
				</td>
				<td class="blue">�ֶα�ע˵��</td>
				<td>
					<input name="fieldNote" type="text" class="button" id="fieldNote"  maxlength="225"  value="<%=(fieldNote==null)?"":fieldNote%>" colspan="3">
               </td>
           </tr>
	</table>
       
       <TABLE cellSpacing="0" >
		<TR id='footer'>
			<TD id="footer" align="center">		
				<input name="add_user" class="b_foot" type="button" id="add_user"   onClick="submitInputAdd('s3520.jsp?action=add_user')" value="����">           
                <input name="bat_del_user" class="b_foot" type="button" id="bat_del_user"   onClick="doDelete();return false;" value="ɾ��">
				<input name="que_user" class="b_foot"  type="button" id="que_user"   onClick="submitInput('s3520.jsp?action=que_user')" value="��ѯ">
				<input name="d" type="button" class="b_foot" value="���" onClick="javascript:clearForm()">
				<input name="goBack" class="b_foot" type="button" id="goBack"   onClick="removeCurrentTab()" value="�ر�">
			</TD>
			<TD></TD>
		</TR>
		<tr>
                <%if ("add_user".equals(action)&& bUserExist){%>
                <SCRIPT LANGUAGE=javascript>
                	rdShowMessageDialog("�ô����Ѿ�����",0)
                	clearForm()
                </SCRIPT>
                <%}%>
       </tr>		
	</table>

	
       
    <!--//<table cellspacing="0">

     //<TR align="center"> 
	//	<TD><strong><font color="green">��ѡ����</font></TD>
	//	<TH>�������� </TH> 
	//	<TH>�������� </TH>
	//	<TH>�������� </TH>
	//	<TH>�������� </TH>
	//	<TH>��ע��Ϣ </TH>               	                             	              
	//</TR>
	-->
        		
	<table cellspacing="0">
		<input type="hidden" name="chkBoxNum"  value="<%=list.size()%>">
            <TR>
                     <td class="blue"><strong><div><font color="green"><a href="" onClick="doSelectAll();return false;">ȫѡ</font></a></div></TD>
                     <TH class="blue"><div>ҵ������</div></TH>
                     <TH class="blue"><div>�ֶδ���</div></TH>
                     <TH class="blue"><div>�ֶδ�������</div></TH>
					 <TH class="blue"><div>�ֶ���;</div></TH>
                     <TH class="blue"><div>�ֶ�����</div></TH>
                     <TH class="blue"><div>�ֶ���󳤶�</div></TH>
	       			 <TH class="blue"><div>�ֶα�ע˵��</div></TH>
             </tr>
                   <% for (int i=0;i<list.size();i++) { %>
					<% String[] array = (String[]) list.get(i);
					   String arr4 ="";
					   String arr2="";
					   if (array[4].equals("09"))
						   arr4="����";
					   if (array[4].equals("10"))
						   arr4="����";
					   if (array[4].equals("11"))
						   arr4="������";
					   if (array[4].equals("12"))
						   arr4="�ַ���";
					   if (array[4].equals("13"))
						   arr4="���";
					   if (array[4].equals("14"))
						   arr4="������";
					   if (array[4].equals("15"))
						   arr4="����ʱ����";
					   if (array[4].equals("16"))
						   arr4="BOOL��";
					   if (array[4].equals("17"))
						   arr4="�̶��б�";
					   if (array[3].equals("10"))
						   arr2="���ô���";
					   if (array[3].equals("11"))
						   arr2="����";

					%>
                      <%if((i+1)%2==1){%>
                          <tr >
		      <%}else{%>
			  <tr>
		      <%}%>
                 
    <td align="center">
                       <input type="checkbox" name="ChkBoxDelete_<%=i%>" value="<%=array[0]+","+array[1]%>" >
                     </td>
                     <td class="blue"> <a href="s3520_m.jsp?busiType=<%=array[0]%>&fieldCode=<%=array[1]%>&fieldName=<%=array[2]%>&fieldPurpose=<%=array[3]%>&fieldType=<%=array[4]%>&fieldLength=<%=array[5]%>&fieldNote=<%=array[6]%>"> <%=array[0]%> </a> </td>
					 <td class="blue"> <%=array[1]%> </td>
					 <td class="blue"> <%=array[2]%> </td>
					 <td class="blue"> <%=arr2%> </td>
                     <td class="blue"> <%=arr4%> </td>
                     <td class="blue"><%=array[5]%></td>
                     <td class="blue"><%=(array[6]==null)?"":array[6]%></td>            
                   </tr>
                   <% } %>
                 </table>
				</td>
</tr>
<tr>
          
				<td>
			
	<table width="720" border="0" cellspacing="1" align="center" class="1"	>
		<input type="hidden" name="page" value="">
		<input type="hidden" name="myaction" value="">
		<tr>
            
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
  </BODY>
 </HTML>

