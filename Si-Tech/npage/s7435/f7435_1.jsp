<%
/********************
 * version v3.0
 * ������: si-tech
 * ��  �ܣ�7435 - ���Ų�Ʒ�������Ʊ�����
 * ��  ����ʵ�ֶ����ñ�cGrpSmLimit��cServerNoLimit��cGrpSmAttrDeal��Sapninfo������ɾ���ġ���
 * author: qidp @ 2009-06-22
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.util.page.*"%>


<%
	String opCode="7435";
	String opName="���Ų�Ʒ�������Ʊ�����";
	
	String regionCode = (String)session.getAttribute("regCode");
	
	String[][] result = new String[][]{};
	String [] paraIn = new String[2];
	
	String iTableName = request.getParameter("tableName")==null?"grpSm":request.getParameter("tableName");
	/***��ҳ��Ϣ***/
	int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
    int iPageSize = 10;
    int iStartPos = (iPageNumber-1)*iPageSize+1;
    int iEndPos = iPageNumber*iPageSize+1;
    String[][] allNumStr =  new String[][]{};
    /**************/

    String sql = "";

/*********************
 * ȡ�� cGrpSmLimit ��Ϣ
 *********************/

    String sql1 = "",sql10="",sql11="";
    String sqlFilter1 = "";
    
    String[][] grpSmArr = new String[][]{};
    String iGrpSmSmCode = "";
    String iGrpSmLimitType = "";
    String iGrpSmLimitValue = "";
    String iGrpSmLimitFlag = "";
if("grpSm".equals(iTableName)){
try{
    iGrpSmSmCode = request.getParameter("grpSmSmCode")==null?"":request.getParameter("grpSmSmCode");
    iGrpSmLimitType = request.getParameter("grpSmLimitType")==null?"":request.getParameter("grpSmLimitType");
    iGrpSmLimitValue = request.getParameter("grpSmLimitValue")==null?"":request.getParameter("grpSmLimitValue");
    iGrpSmLimitFlag = request.getParameter("grpSmLimitFlag")==null?"":request.getParameter("grpSmLimitFlag");
    
    
    
    if (iGrpSmSmCode != null && iGrpSmSmCode.trim().length() > 0)
        sqlFilter1 = sqlFilter1 + " and sm_code = '" + iGrpSmSmCode + "' ";
    if (iGrpSmLimitType != null && iGrpSmLimitType.trim().length() > 0)
        sqlFilter1 = sqlFilter1 + " and limit_type = '" + iGrpSmLimitType + "' ";
    if (iGrpSmLimitValue != null && iGrpSmLimitValue.trim().length() > 0)
        sqlFilter1 = sqlFilter1 + " and limit_value = '" + iGrpSmLimitValue + "' ";
    if (iGrpSmLimitFlag != null && iGrpSmLimitFlag.trim().length() > 0 )
        sqlFilter1 = sqlFilter1 + " and limit_flag = '" + iGrpSmLimitFlag + "' ";
        
    sql1 = "select sm_code,limit_type,limit_value,limit_flag from cGrpSmLimit where 1=1 " + sqlFilter1;
    sql10 = "select count(*) from ("+ sql1 +")";
    sql11 = "select * from (select f.*,rownum id from (" + sql1 + ") f) where id <"+iEndPos+" and id>="+iStartPos;
%>

    <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="grpSmRetCode2" retmsg="grpSmRetCode2" outnum="1">
    	<wtc:sql><%=sql10%></wtc:sql>
    </wtc:pubselect>
    <wtc:array id="retArr2" scope="end"/>
<%
    allNumStr = retArr2;

%>
    <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="grpSmRetCode" retmsg="grpSmRetMsg"  outnum="4">
    	<wtc:sql><%=sql11%></wtc:sql>
    </wtc:pubselect>
    <wtc:array id="grpSmRetArr" scope="end" />
<%
    if ("000000".equals(grpSmRetCode)){
        if(grpSmRetArr.length > 0){
            grpSmArr = grpSmRetArr;
        }else{
            %>
                <script type="text/javascript">
                    rdShowMessageDialog("��ѯ��Ϣ�����ڣ�",0);
                    history.go(-1);
                </script>
            <%
        }
    }else{
    %>
        <script type="text/javascript">
            rdShowMessageDialog("ȡ��cGrpSmLimit��Ϣʧ�ܣ�<%=grpSmRetMsg%>",0);
            history.go(-1);
        </script>
    <%
    }
}catch(Exception e){
    e.printStackTrace();
}
}

/*********************
 * ȡ��cServerNoLimit��Ϣ
 *********************/

    String sql2 = "",sql20="",sql21="";
    String sqlFilter2 = "";
    
    String[][] serverNoArr = new String[][]{};
    String iServerNoNetAttr = "";
    String iServerNoSmCode = "";
    String iServerNoMaxLength = "";
    String iServerNoMinLength = "";
    String iServerNoAccessFlag = "";
    String iServerNoLengthFlag = "";
if("serverNo".equals(iTableName)){
try{
    iServerNoNetAttr = request.getParameter("serverNoNetAttr")==null?"":request.getParameter("serverNoNetAttr");
    iServerNoSmCode = request.getParameter("serverNoSmCode")==null?"":request.getParameter("serverNoSmCode");
    iServerNoMaxLength = request.getParameter("serverNoMaxLength")==null?"":request.getParameter("serverNoMaxLength");
    iServerNoMinLength = request.getParameter("serverNoMinLength")==null?"":request.getParameter("serverNoMinLength");
    iServerNoAccessFlag = request.getParameter("serverNoAccessFlag")==null?"":request.getParameter("serverNoAccessFlag");
    iServerNoLengthFlag = request.getParameter("serverNoLengthFlag")==null?"":request.getParameter("serverNoLengthFlag");
    
    
    
    if (iServerNoNetAttr != null && iServerNoNetAttr.trim().length() > 0)
        sqlFilter2 = sqlFilter2 + " and net_attr = '" + iServerNoNetAttr + "' ";
    if (iServerNoSmCode != null && iServerNoSmCode.trim().length() > 0)
        sqlFilter2 = sqlFilter2 + " and sm_code = '" + iServerNoSmCode + "' ";
    if (iServerNoMaxLength != null && iServerNoMaxLength.trim().length() > 0)
        sqlFilter2 = sqlFilter2 + " and server_maxlength = '" + iServerNoMaxLength + "' ";
    if (iServerNoMinLength != null && iServerNoMinLength.trim().length() > 0 )
        sqlFilter2 = sqlFilter2 + " and server_minlength = '" + iServerNoMinLength + "' ";
    if (iServerNoAccessFlag != null && iServerNoAccessFlag.trim().length() > 0 )
        sqlFilter2 = sqlFilter2 + " and accsess_flag = '" + iServerNoAccessFlag + "' ";
    if (iServerNoLengthFlag != null && iServerNoLengthFlag.trim().length() > 0 )
        sqlFilter2 = sqlFilter2 + " and length_flag = '" + iServerNoLengthFlag + "' ";
        
    sql2 = "select net_attr,sm_code,server_maxlength,server_minlength,accsess_flag,length_flag from cServerNoLimit where 1=1 " + sqlFilter2;
    sql20 = "select count(*) from ("+ sql2 +")";
    sql21 = "select * from (select f.*,rownum id from (" + sql2 + ") f) where id <"+iEndPos+" and id>="+iStartPos;
    
%>

    <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="serverNoRetCode2" retmsg="serverNoRetMsg2" outnum="1">
    	<wtc:sql><%=sql20%></wtc:sql>
    </wtc:pubselect>
    <wtc:array id="retArr2" scope="end"/>
<%
    allNumStr = retArr2;

%>
    <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="serverNoRetCode" retmsg="serverNoRetMsg"  outnum="6">
    	<wtc:sql><%=sql21%></wtc:sql>
    </wtc:pubselect>
    <wtc:array id="serverNoRetArr" scope="end" />
<%
    if ("000000".equals(serverNoRetCode)){
        if(serverNoRetArr.length > 0){
            serverNoArr = serverNoRetArr;
        }else{
            %>
                <script type="text/javascript">
                    rdShowMessageDialog("��ѯ��Ϣ�����ڣ�",0);
                    history.go(-1);
                </script>
            <%
        }
    }else{
    %>
        <script type="text/javascript">
            rdShowMessageDialog("ȡ��cServerNoLimit��Ϣʧ�ܣ�<%=serverNoRetMsg%>",0);
            history.go(-1);
        </script>
    <%
    }
}catch(Exception e){
    e.printStackTrace();
}
}

/*********************
 * ȡ��cGrpSmAttrDeal��Ϣ
 *********************/

    String sql3 = "",sql30="",sql31="";
    String sqlFilter3 = "";
    
    String[][] grpSmAttrArr = new String[][]{};
    
    String iGrpSmAttrSmCode = "";
    String iGrpSmAttrSmAttr = "";
    String iGrpSmAttrLimitFlag = "";
    String iGrpSmAttrDealType = "";
    String iGrpSmOpType = "";      /*����չ�ֶΡ�����������*/
    String iGrpSmAttrName = "";      /*����չ�ֶΡ�����������*/
    String iGrpSmAttrRequestType = "";     /*����չ�ֶΡ���ҵ����������*/
if("grpSmAttr".equals(iTableName)){
try{
    iGrpSmAttrSmCode = request.getParameter("grpSmAttrSmCode")==null?"":request.getParameter("grpSmAttrSmCode");
    iGrpSmAttrSmAttr = request.getParameter("grpSmAttrSmAttr")==null?"":request.getParameter("grpSmAttrSmAttr");
    iGrpSmAttrLimitFlag = request.getParameter("grpSmAttrLimitFlag")==null?"":request.getParameter("grpSmAttrLimitFlag");
    iGrpSmAttrDealType = request.getParameter("grpSmAttrDealType")==null?"":request.getParameter("grpSmAttrDealType");
    iGrpSmOpType = request.getParameter("grpSmOpType")==null?"":request.getParameter("grpSmOpType");
    iGrpSmAttrName = request.getParameter("grpSmAttrName")==null?"":request.getParameter("grpSmAttrName");
    iGrpSmAttrRequestType = request.getParameter("grpSmAttrRequestType")==null?"":request.getParameter("grpSmAttrRequestType");
    
    
    if (iGrpSmAttrSmCode != null && iGrpSmAttrSmCode.trim().length() > 0)
        sqlFilter3 = sqlFilter3 + " and sm_code = '" + iGrpSmAttrSmCode + "' ";
    if (iGrpSmAttrSmAttr != null && iGrpSmAttrSmAttr.trim().length() > 0)
        sqlFilter3 = sqlFilter3 + " and sm_attr = '" + iGrpSmAttrSmAttr + "' ";
    if (iGrpSmAttrLimitFlag != null && iGrpSmAttrLimitFlag.trim().length() > 0)
        sqlFilter3 = sqlFilter3 + " and limit_flag = '" + iGrpSmAttrLimitFlag + "' ";
    if (iGrpSmAttrDealType != null && iGrpSmAttrDealType.trim().length() > 0 )
        sqlFilter3 = sqlFilter3 + " and deal_type = '" + iGrpSmAttrDealType + "' ";
    if (iGrpSmOpType != null && iGrpSmOpType.trim().length() > 0 )
        sqlFilter3 = sqlFilter3 + " and op_type = '" + iGrpSmOpType + "' ";    
    if (iGrpSmAttrName != null && iGrpSmAttrName.trim().length() > 0 )
        sqlFilter3 = sqlFilter3 + " and attr_name = '" + iGrpSmAttrName + "' ";   
	if (iGrpSmAttrRequestType != null && iGrpSmAttrRequestType.trim().length() > 0 )
        sqlFilter3 = sqlFilter3 + " and request_type = '" + iGrpSmAttrRequestType + "' ";   
        
        
        
    sql3 = "select sm_code,sm_attr, limit_flag,deal_type,attr_name,op_type,request_type from cGrpSmAttrDeal where 1=1 " + sqlFilter3;
    sql30 = "select count(*) from ("+ sql3 +")";
    sql31 = "select * from (select f.*,rownum id from (" + sql3 + ") f) where id <"+iEndPos+" and id>="+iStartPos;
    
%>

    <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="grpSmAttrRetCode2" retmsg="grpSmAttrRetCode2" outnum="1">
    	<wtc:sql><%=sql30%></wtc:sql>
    </wtc:pubselect>
    <wtc:array id="retArr2" scope="end"/>
<%
    allNumStr = retArr2;

%>
    <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="grpSmAttrRetCode" retmsg="grpSmAttrRetMsg"  outnum="7">
    	<wtc:sql><%=sql31%></wtc:sql>
    </wtc:pubselect>
    <wtc:array id="grpSmAttrRetArr" scope="end" />
<%
    if ("000000".equals(grpSmAttrRetCode)){
        if(grpSmAttrRetArr.length > 0){
            grpSmAttrArr = grpSmAttrRetArr;
        }else{
            %>
                <script type="text/javascript">
                    rdShowMessageDialog("��ѯ��Ϣ�����ڣ�",0);
                    history.go(-1);
                </script>
            <%
        }
    }else{
    %>
        <script type="text/javascript">
            rdShowMessageDialog("ȡ��cGrpSmAttrDeal��Ϣʧ�ܣ�<%=grpSmAttrRetMsg%>",0);
            history.go(-1);
        </script>
    <%
    }
}catch(Exception e){
    e.printStackTrace();
}
}
/*********************
 * ȡ�� Sapninfo ��Ϣ
 *********************/

    String sql4 = "",sql40="",sql41="";
    String sqlFilter4 = "";
    
    String[][] apnInfoArr = new String[][]{};
    String iApnInfoRegCode = "";
    String iApnInfoSmCode = "";
    String iApnInfoApnCode = "";
    String iApnInfoApnId = "";
    String iApnInfoTermType = "";
    String iApnInfoRoamType = "";
    String iApnInfoOtherCode = "";
    String iApnInfoValidFlag = "";
    String iApnInfoRequestType = "";
    String iApnInfoProSpecNo = "";
       
if("apnInfo".equals(iTableName)){
try{
    iApnInfoRegCode = request.getParameter("apnInfoRegCode")==null?"":request.getParameter("apnInfoRegCode");
    iApnInfoSmCode = request.getParameter("apnInfoSmCode")==null?"":request.getParameter("apnInfoSmCode");
    iApnInfoApnCode = request.getParameter("apnInfoApnCode")==null?"":request.getParameter("apnInfoApnCode");
    iApnInfoApnId = request.getParameter("apnInfoApnCode")==null?"":request.getParameter("apnInfoApnId");
    iApnInfoTermType = request.getParameter("apnInfoTermType")==null?"":request.getParameter("apnInfoTermType");
    iApnInfoRoamType = request.getParameter("apnInfoRoamType")==null?"":request.getParameter("apnInfoRoamType");
    iApnInfoOtherCode = request.getParameter("apnInfoOtherCode")==null?"":request.getParameter("apnInfoOtherCode");
    iApnInfoValidFlag = request.getParameter("apnInfoValidFlag")==null?"":request.getParameter("apnInfoValidFlag");
    iApnInfoRequestType = request.getParameter("apnInfoRequestType")==null?"":request.getParameter("apnInfoRequestType");
    iApnInfoProSpecNo = request.getParameter("apnInfoProSpecNo")==null?"":request.getParameter("apnInfoProSpecNo");
    
    
    
    if (iApnInfoRegCode != null && iApnInfoRegCode.trim().length() > 0)
        sqlFilter4 = sqlFilter4 + " and region_code = '" + iApnInfoRegCode + "' ";
    if (iApnInfoSmCode != null && iApnInfoSmCode.trim().length() > 0)
        sqlFilter4 = sqlFilter4 + " and sm_code = '" + iApnInfoSmCode + "' ";
    if (iApnInfoApnCode != null && iApnInfoApnCode.trim().length() > 0)
        sqlFilter4 = sqlFilter4 + " and apn_code = '" + iApnInfoApnCode + "' ";
    if (iApnInfoApnId != null && iApnInfoApnId.trim().length() > 0 )
        sqlFilter4 = sqlFilter4 + " and apn_id = '" + iApnInfoApnId + "' ";
    if (iApnInfoTermType != null && iApnInfoTermType.trim().length() > 0 )
        sqlFilter4 = sqlFilter4 + " and terminal_type = '" + iApnInfoTermType + "' ";
    if (iApnInfoRoamType != null && iApnInfoRoamType.trim().length() > 0 )
        sqlFilter4 = sqlFilter4 + " and roam_type = '" + iApnInfoRoamType + "' ";
    if (iApnInfoOtherCode != null && iApnInfoOtherCode.trim().length() > 0 )
        sqlFilter4 = sqlFilter4 + " and other_code = '" + iApnInfoOtherCode + "' ";
	if (iApnInfoValidFlag != null && iApnInfoValidFlag.trim().length() > 0 )
        sqlFilter4 = sqlFilter4 + " and valid_flag = '" + iApnInfoValidFlag + "' ";
	if (iApnInfoRequestType != null && iApnInfoRequestType.trim().length() > 0 )
        sqlFilter4 = sqlFilter4 + " and request_type = '" + iApnInfoRequestType + "' ";
	if (iApnInfoProSpecNo != null && iApnInfoProSpecNo.trim().length() > 0 ) 
        sqlFilter4 = sqlFilter4 + " and ProductSpecNumber = '" + iApnInfoProSpecNo + "' ";
        
    sql4 = "select region_code,sm_code,apn_code,apn_id,terminal_type,roam_type,other_code,valid_flag,request_type,ProductSpecNumber from Sapninfo where 1=1 " + sqlFilter4;
    sql40 = "select count(*) from ("+ sql4 +")";
    sql41 = "select * from (select f.*,rownum id from (" + sql4 + ") f) where id <"+iEndPos+" and id>="+iStartPos;
    
%>

    <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="apnInfoRetCode2" retmsg="apnInfoRetCode2" outnum="1">
    	<wtc:sql><%=sql40%></wtc:sql>
    </wtc:pubselect>
    <wtc:array id="retArr2" scope="end"/>
<%
    allNumStr = retArr2;    

%>
    <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="apnInfoRetCode" retmsg="apnInfoRetMsg"  outnum="10">
    	<wtc:sql><%=sql41%></wtc:sql>
    </wtc:pubselect>
    <wtc:array id="apnInfoRetArr" scope="end" />
<%
   
    if ("000000".equals(apnInfoRetCode)){
        if(apnInfoRetArr.length > 0){
            apnInfoArr = apnInfoRetArr;
            System.out.println("00000000000000000000000="+apnInfoRetArr.length );
        }else{
        	System.out.println("00000000000000000000000="+apnInfoRetArr.length );
            %>
                <script type="text/javascript">
                    rdShowMessageDialog("��ѯ��Ϣ�����ڣ�",0);
                    history.go(-1);
                </script>
            <%
        }
    }else{
    %>
        <script type="text/javascript">
            rdShowMessageDialog("ȡ��SapnInfo��Ϣʧ�ܣ�<%=apnInfoRetMsg%>",0);
            history.go(-1);
        </script>
    <%
    }
}catch(Exception e){
    e.printStackTrace();
}
}
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE>���Ų�Ʒ�������Ʊ�����</TITLE>
</HEAD>
<script type="text/javascript">
	onload=function()
	{
	    
	    <%if("grpSm".equals(iTableName)){%>
            document.all.grpSmSmCode.value = "<%=iGrpSmSmCode%>";
            document.all.grpSmLimitType.value = "<%=iGrpSmLimitType%>";
            document.all.grpSmLimitValue.value = "<%=iGrpSmLimitValue%>";
            document.all.grpSmLimitFlag.value = "<%=iGrpSmLimitFlag%>";
        <%}%>
        
        <%if("serverNo".equals(iTableName)){%>
            document.all.serverNoNetAttr.value = "<%=iServerNoNetAttr%>";
            document.all.serverNoSmCode.value = "<%=iServerNoSmCode%>";
            document.all.serverNoMaxLength.value = "<%=iServerNoMaxLength%>";
            document.all.serverNoMinLength.value = "<%=iServerNoMinLength%>";
            document.all.serverNoAccessFlag.value = "<%=iServerNoAccessFlag%>";
            document.all.serverNoLengthFlag.value = "<%=iServerNoLengthFlag%>";
        <%}%>
        
        <%if("grpSmAttr".equals(iTableName)){%>
            document.all.grpSmAttrSmCode.value = "<%=iGrpSmAttrSmCode%>";
            document.all.grpSmAttrSmAttr.value = "<%=iGrpSmAttrSmAttr%>";
            document.all.grpSmAttrLimitFlag.value = "<%=iGrpSmAttrLimitFlag%>";
            document.all.grpSmAttrDealType.value = "<%=iGrpSmAttrDealType%>";
            document.all.grpSmOpType.value = "<%=iGrpSmOpType%>";
            document.all.grpSmAttrName.value = "<%=iGrpSmAttrName%>";
            document.all.grpSmAttrRequestType.value = "<%=iGrpSmAttrRequestType%>";
        <%}%>

        <%if("apnInfo".equals(iTableName)){%>
            document.all.apnInfoRegCode.value = "<%=iApnInfoRegCode%>";
            document.all.apnInfoSmCode.value = "<%=iApnInfoSmCode%>";
            document.all.apnInfoApnCode.value = "<%=iApnInfoApnCode%>";
            document.all.apnInfoApnId.value = "<%=iApnInfoApnId%>";
            document.all.apnInfoTermType.value = "<%=iApnInfoTermType%>";
            document.all.apnInfoRoamType.value = "<%=iApnInfoRoamType%>";
            document.all.apnInfoOtherCode.value = "<%=iApnInfoOtherCode%>";
            document.all.apnInfoValidFlag.value = "<%=iApnInfoValidFlag%>";
            document.all.apnInfoRequestType.value = "<%=iApnInfoRequestType%>";
            document.all.apnInfoProSpecNo.value = "<%=iGrpSmAttrDealType%>";
        <%}%>
 
    
    
	    var tabName = "<%=iTableName%>";
	    document.all.tableName.value = tabName;
	    
        if(tabName == "grpSm"){
            document.all.grpSm.style.display="";
            document.all.serverNo.style.display="none";
            document.all.grpSmAttr.style.display="none";
            document.all.apnInfo.style.display="none";
        }else if(tabName == "serverNo"){
            document.all.grpSm.style.display="none";
            document.all.serverNo.style.display="";
            document.all.grpSmAttr.style.display="none";
            document.all.apnInfo.style.display="none";
        }else if(tabName == "grpSmAttr"){
            document.all.grpSm.style.display="none";
            document.all.serverNo.style.display="none";
            document.all.grpSmAttr.style.display="";
            document.all.apnInfo.style.display="none";
        }else if(tabName == "apnInfo"){
            document.all.grpSm.style.display="none";
            document.all.serverNo.style.display="none";
            document.all.grpSmAttr.style.display="none";
            document.all.apnInfo.style.display="";
        }
		
	}
    
    /*********************
     * ����������ѡ�񣬿��Ƹ����ñ��Ӧ�� tbody ��ʾ������
     *********************/
    function chgTable(){
        frm.action="f7435_1.jsp";
        frm.method="post";
        frm.submit();
    }
    
    /* �ύ */
    function refMain(){
        if(document.all.opType.value == "03"){//��ѯ
            frm.action="f7435_1.jsp";
            frm.method="post";
            frm.submit();
            return true;
        }
        
        var tabName = document.all.tableName.value;
        var pageName = "";
        if(tabName == "grpSm"){
            if(document.all.opType.value == "00"){
                //�ж�checkbox�Ƿ�ѡ��
                var len = document.all.grpSmCheck.length; 
                var checked = false; 
                if(len!=undefined && len!="undefined"){
                    for (i = 0; i < len; i++) 
                    { 
                        if (document.all.grpSmCheck[i].checked == true) 
                        { 
                            checked = true; 
                            break; 
                        } 
                    }
                }else{
                    if (document.all.grpSmCheck.checked == true)
                    { 
                        checked = true; 
                    }
                }
                if (!checked) 
                { 
                    rdShowMessageDialog("������ѡ��һ����Ҫɾ�������ݣ�");
                    return false; 
                }
            }
            if(document.all.grpSmSmCode.value==""){
                rdShowMessageDialog("Ʒ�Ʋ���Ϊ��!");
                document.all.grpSmSmCode.focus();
                return false;
            }
            if(document.all.grpSmLimitType.value==""){
                rdShowMessageDialog("���������Ϊ��!");
                document.all.grpSmLimitType.focus();
                return false;
            }
            if(document.all.grpSmLimitValue.value==""){
                rdShowMessageDialog("����ֵ����Ϊ��!");
                document.all.grpSmLimitValue.focus();
                return false;
            }
            if(document.all.grpSmLimitFlag.value==""){
                rdShowMessageDialog("���Ʊ�־����Ϊ��!");
                document.all.grpSmLimitFlag.focus();
                return false;
            }
            
            pageName = "f7435Cfm_1.jsp";
        }
        
        if(tabName == "serverNo"){
            if(document.all.opType.value == "00"){
                //�ж�checkbox�Ƿ�ѡ��
                var len = document.all.serverNoCheck.length; 
                var checked = false; 
                if(len!=undefined && len!="undefined"){
                    for (i = 0; i < len; i++) 
                    { 
                        if (document.all.serverNoCheck[i].checked == true) 
                        { 
                            checked = true; 
                            break; 
                        } 
                    } 
                }else{
                    if (document.all.serverNoCheck.checked == true) 
                    { 
                        checked = true; 
                    } 
                }
                if (!checked) 
                { 
                    rdShowMessageDialog("������ѡ��һ����Ҫɾ�������ݣ�");
                    return false; 
                }
            }
            if(document.all.serverNoNetAttr.value==""){
                rdShowMessageDialog("�������Բ���Ϊ��!");
                document.all.serverNoNetAttr.focus();
                return false;
            }
            if(document.all.serverNoSmCode.value==""){
                rdShowMessageDialog("Ʒ�Ʋ���Ϊ��!");
                document.all.serverNoSmCode.focus();
                return false;
            }
            if(document.all.serverNoAccessFlag.value==""){
                rdShowMessageDialog("�Ƿ�ȽϽ���Ų���Ϊ��!");
                document.all.serverNoAccessFlag.focus();
                return false;
            }
            if(document.all.serverNoLengthFlag.value==""){
                rdShowMessageDialog("�Ƿ��жϷ���ų��Ȳ���Ϊ��!");
                document.all.serverNoLengthFlag.focus();
                return false;
            }
            
            pageName = "f7435Cfm_2.jsp";
        }
        
        if(tabName == "grpSmAttr"){
            if(document.all.opType.value == "00"){
                //�ж�checkbox�Ƿ�ѡ��
                var len = document.all.grpSmAttrCheck.length; 
                var checked = false; 
                if(len!=undefined && len!="undefined"){
                    for (i = 0; i < len; i++) 
                    { 
                        if (document.all.grpSmAttrCheck[i].checked == true) 
                        { 
                            checked = true; 
                            break; 
                        } 
                    } 
                }else{
                    if (document.all.grpSmAttrCheck.checked == true) 
                    { 
                        checked = true; 
                    }
                }
                if (!checked) 
                { 
                    rdShowMessageDialog("������ѡ��һ����Ҫɾ�������ݣ�");
                    return false; 
                }
            }
            if(document.all.grpSmAttrSmCode.value==""){
                rdShowMessageDialog("Ʒ�Ʋ���Ϊ��!");
                document.all.grpSmAttrSmCode.focus();
                return false;
            }
            if(document.all.grpSmAttrSmAttr.value==""){
                rdShowMessageDialog("���Դ��벻��Ϊ��!");
                document.all.grpSmAttrSmAttr.focus();
                return false;
            }
            if(document.all.grpSmAttrLimitFlag.value==""){
                rdShowMessageDialog("�Ƿ����Ʋ���Ϊ��!");
                document.all.grpSmAttrLimitFlag.focus();
                return false;
            }
            if(document.all.grpSmAttrDealType.value==""){
                rdShowMessageDialog("�������Ͳ���Ϊ��!");
                document.all.grpSmAttrDealType.focus();
                return false;
            }
			if(document.all.grpSmOpType.value==""){
                rdShowMessageDialog("�������Ͳ���Ϊ��!");
                document.all.grpSmOpType.focus();
                return false;
            }
            pageName = "f7435Cfm_3.jsp";
        }
        
		if(tabName == "apnInfo"){
         if(document.all.opType.value == "00"){
            //�ж�checkbox�Ƿ�ѡ��
            var checkedapn = false; 
            if(document.all.apnInfoCheck.length!=undefined){
                var len = document.all.apnInfoCheck.length; 
                
                for (i = 0; i < len; i++) 
                { 
                    if (document.all.apnInfoCheck[i].checked == true) 
                    { 
                        checkedapn = true; 
                        break; 
                    } 
                } 
                
            }else{
                if (document.all.apnInfoCheck.checked == true)
                { 
                    checkedapn = true; 
                } 
            }
            
            if(!checkedapn) 
            { 
                rdShowMessageDialog("������ѡ��һ����Ҫɾ�������ݣ�");
                return false; 
            }
        }
            if(document.all.apnInfoRegCode.value==""){
                rdShowMessageDialog("��������Ϊ��!");
                document.all.apnInfoRegCode.focus();
                return false;
            }
            if(document.all.apnInfoSmCode.value==""){
                rdShowMessageDialog("Ʒ�Ʋ���Ϊ��!");
                document.all.apnInfoSmCode.focus();
                return false;
            }
            if(document.all.apnInfoApnCode.value==""){
                rdShowMessageDialog("apn���벻��Ϊ��!");
                document.all.apnInfoApnCode.focus();
                return false;
            }
            if(document.all.apnInfoApnId.value==""){
                rdShowMessageDialog("apn ID����Ϊ��!");
                document.all.apnInfoApnId.focus();
                return false;
            }
			if(document.all.apnInfoTermType.value==""){
                rdShowMessageDialog("�ն����Ͳ���Ϊ��!");
                document.all.apnInfoTermType.focus();
                return false;
            }
            if(document.all.apnInfoRoamType.value==""){
                rdShowMessageDialog("�������Ͳ���Ϊ��!");
                document.all.apnInfoRoamType.focus();
                return false;
            }
			if(document.all.apnInfoValidFlag.value==""){
                rdShowMessageDialog("�Ƿ���Ч����Ϊ��!");
                document.all.apnInfoValidFlag.focus();
                return false;
            }
            
            pageName = "f7435Cfm_4.jsp";
        }
        
        var confirmFlag=0;
        confirmFlag = rdShowConfirmDialog("�Ƿ��ύ���β�����");
		if (confirmFlag==1) {
		    $("select:disabled").attr("disabled",false);
			frm.action=pageName;
            frm.method="post";
            frm.submit();
		}
    }
    
    function grpSmFocusFunc(rowno){
        document.all.row_no.value = rowno;
        $("tbody[name='grpSmList'] tr[name='row"+rowno+"']").css("color","red");
        $("tbody[name='grpSmList'] tr[name!='row"+rowno+"']").css("color","blue");
        
        document.all.grpSmSmCode.value=document.getElementById("grpSmSmCode"+rowno).value;
        document.all.grpSmLimitType.value=document.getElementById("grpSmLimitType"+rowno).value;
        document.all.grpSmLimitValue.value=document.getElementById("grpSmLimitValue"+rowno).value;
        document.all.grpSmLimitFlag.value=document.getElementById("grpSmLimitFlag"+rowno).value;
    }

    function serverNoFocusFunc(rowno){
        document.all.row_no.value = rowno;
        $("tbody[name='serverNoList'] tr[name='row"+rowno+"']").css("color","red");
        $("tbody[name='serverNoList'] tr[name!='row"+rowno+"']").css("color","blue");
        
        document.all.serverNoNetAttr.value=document.getElementById("serverNoNetAttr"+rowno).value;
        document.all.serverNoSmCode.value=document.getElementById("serverNoSmCode"+rowno).value;
        document.all.serverNoMaxLength.value=document.getElementById("serverNoMaxLength"+rowno).value;
        document.all.serverNoMinLength.value=document.getElementById("serverNoMinLength"+rowno).value;
        document.all.serverNoAccessFlag.value=document.getElementById("serverNoAccessFlag"+rowno).value;
        document.all.serverNoLengthFlag.value=document.getElementById("serverNoLengthFlag"+rowno).value;
    }
    
    function grpSmAttrFocusFunc(rowno){
        document.all.row_no.value = rowno;
        $("tbody[name='grpSmAttrList'] tr[name='row"+rowno+"']").css("color","red");
        $("tbody[name='grpSmAttrList'] tr[name!='row"+rowno+"']").css("color","blue");
        
        document.all.grpSmAttrSmCode.value=document.getElementById("grpSmAttrSmCode"+rowno).value;
        document.all.grpSmAttrSmAttr.value=document.getElementById("grpSmAttrSmAttr"+rowno).value;
        document.all.grpSmAttrLimitFlag.value=document.getElementById("grpSmAttrLimitFlag"+rowno).value;
        document.all.grpSmAttrDealType.value=document.getElementById("grpSmAttrDealType"+rowno).value;
        
        document.all.grpSmOpType.value=document.getElementById("grpSmOpType"+rowno).value;
        document.all.grpSmAttrName.value=document.getElementById("grpSmAttrName"+rowno).value;
        document.all.grpSmAttrRequestType.value=document.getElementById("grpSmAttrRequestType"+rowno).value;        
    }
    function apnInfoFocusFunc(rowno){
        document.all.row_no.value = rowno;
        $("tbody[name='apnInfoList'] tr[name='row"+rowno+"']").css("color","red");
        $("tbody[name='apnInfoList'] tr[name!='row"+rowno+"']").css("color","blue");
        
        document.all.apnInfoRegCode.value=document.getElementById("apnInfoRegCode"+rowno).value;
        document.all.apnInfoSmCode.value=document.getElementById("apnInfoSmCode"+rowno).value;
        document.all.apnInfoApnCode.value=document.getElementById("apnInfoApnCode"+rowno).value;
        document.all.apnInfoApnId.value=document.getElementById("apnInfoApnId"+rowno).value;
        document.all.apnInfoTermType.value=document.getElementById("apnInfoTermType"+rowno).value;
        document.all.apnInfoRoamType.value=document.getElementById("apnInfoRoamType"+rowno).value;
        document.all.apnInfoOtherCode.value=document.getElementById("apnInfoOtherCode"+rowno).value;   
        document.all.apnInfoValidFlag.value=document.getElementById("apnInfoValidFlag"+rowno).value;
        document.all.apnInfoRequestType.value=document.getElementById("apnInfoRequestType"+rowno).value;
        document.all.apnInfoProSpecNo.value=document.getElementById("apnInfoProSpecNo"+rowno).value;      
    }
  
    //��������ӡ���ťʱ����
    function addFunc(){
        document.all.opType.value="02";
        $("select[name^='grpSm'],[name^='serverNo'],[name^='grpSmAttr'],[name^='apnInfo']").attr("disabled",false);
        $("input[type='text'][name^='grpSm'],[name^='serverNo'],[name^='grpSmAttr'],[name^='apnInfo']").removeAttr("readOnly");
        $("input[type='text'][name^='grpSm'],[name^='serverNo'],[name^='grpSmAttr'],[name^='apnInfo']").removeClass("InputGrey");
        
        $("input[type='button'][name='addBtn'],[name='mdfBtn'],[name='delBtn']").attr("disabled",true);//�����ӡ������޸ġ�����ɾ������ť��Ϊ������
        $("input[type='button'][name='sureBtn']").attr("disabled",false);//��ȷ������ť��Ϊ����
    }
    
    //������޸ġ���ťʱ����
    function modifyFunc(){
        document.all.opType.value="01";
        var mdfLabel = document.all.row_no.value;
        if(mdfLabel == ""){
            rdShowMessageDialog("��ѡ����Ҫ�޸ĵ�����",0);
            return false;
        }
        $("select[modifyFlag!='Y']").attr("disabled",false);
        $("input[type='text'][modifyFlag!='Y']").removeAttr("readOnly");
        $("input[type='text'][modifyFlag!='Y']").removeClass("InputGrey");
        
        $("input[type='button'][name='addBtn'],[name='mdfBtn'],[name='delBtn']").attr("disabled",true);//�����ӡ������޸ġ�����ɾ������ť��Ϊ������
        $("input[type='button'][name='sureBtn']").attr("disabled",false);//��ȷ������ť��Ϊ����
    }
    
    //�����ɾ������ťʱ����
    function deleteFunc(){
        document.all.opType.value="00";
        $(":checkbox").attr("disabled",false);
        
        $("input[type='button'][name='addBtn'],[name='mdfBtn'],[name='delBtn']").attr("disabled",true);//�����ӡ������޸ġ�����ɾ������ť��Ϊ������
        $("input[type='button'][name='sureBtn']").attr("disabled",false);//��ȷ������ť��Ϊ����
    }
    
    //�������ѯ����ťʱ����
    function selectFunc(){
        document.all.opType.value="03";
             
        $("select[name^='grpSm'],[name^='serverNo'],[name^='grpSmAttr'],[name^='apnInfo']").attr("disabled",false);     
        $("input[type='text'][name^='grpSm'],[name^='serverNo'],[name^='grpSmAttr'],[name^='apnInfo']").removeAttr("readOnly");
        $("input[type='text'][name^='grpSm'],[name^='serverNo'],[name^='grpSmAttr'],[name^='apnInfo']").removeClass("InputGrey");
        
        $("input[type='button'][name='addBtn'],[name='sltBtn']").attr("disabled",true);//�����ӡ������޸ġ�����ɾ����������ѯ����ť��Ϊ������
        $("input[type='button'][name='sureBtn']").attr("disabled",false);//��ȷ������ť��Ϊ����
		
    }
    
</script>

<body>
<form action="" method="post" name="frm">
	<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">���Ʊ���Ϣ</div>
</div>
<table cellspacing="0">
    <tr>
        <td class="blue">���Ʊ�ѡ��</td>
        <td colspan="4">
        	<select name="tableName" id="tableName" onChange="chgTable()">
        	    <option value="grpSm" >cGrpSmLimit-����ҵ��Ʒ������</option>
        	    <option value="serverNo" >cServerNoLimit-���������</option>
        	    <!-- <option value="grpSmAttr" >cGrpSmAttrDeal-����Ʒ�����Դ���</option> -->
        	    <option value="apnInfo" >Sapninfo-��ԱAPN��Ϣ</option>
        	</select>
        </td>
    </tr>
    <tbody id="grpSm" name="grpSm" style="display:">
    	
        <tr>
            <td class="blue">Ʒ��</td>
            <td>
                <select name="grpSmSmCode" id="grpSmSmCode" disabled modifyFlag="Y" >
                    <option value=""   >             </option>
                <%
        try
        {
            
            sql = "select a.sm_code, a.sm_name "
                + " from sSmCode a, sBusiTypeSmCode b "
                + " where a.sm_code = b.sm_code "
                + " and a.region_code = :regionCode";
            paraIn[0] = sql;    
            paraIn[1]="regionCode="+regionCode;
            %>
                <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode16" retmsg="retMsg16" outnum="2" >
                    <wtc:param value="<%=paraIn[0]%>"/>
                    <wtc:param value="<%=paraIn[1]%>"/> 
                </wtc:service>
                <wtc:array id="retArr16" scope="end"/>
            <%					
            //result = (String[][])retArray.get(0);
            if(retCode16.equals("000000")){
                result = retArr16;
            }
            int recordNum = result.length;
            for(int i=0;i<recordNum;i++)
            {
                out.println("<option class='button' value='" + result[i][0].trim() + "'");
                out.print(">" + result[i][1] + "</option>");
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        %>
    </select>
                <font class="orange">*</font>
            </td>
            <td class="blue">�������</td>
            <td>
                <select name="grpSmLimitType" id="grpSmLimitType" disabled modifyFlag="Y" >
                    <option value=""   >             </option>
            	    <option value="00" >00-->���ŵȼ�</option>
            	    <option value="01" >01-->�ͻ����</option>
            	    <option value="02" >02-->Ŀ��Ʒ��</option>
            	</select>
                <font class="orange">*</font>
            </td>
        </tr>
        <tr>       
            <td class="blue">����ֵ</td>
            <td>
                <input name="grpSmLimitValue" id="grpSmLimitValue" type="text" value="" class="InputGrey" readOnly modifyFlag="Y" />
                <font class="orange">*</font>
            </td>
            <td class="blue">���Ʊ�־</td>
            <td>
                <select name="grpSmLimitFlag" id="grpSmLimitFlag" disabled >
                    <option value=""   >             </option>
            	    <option value="Y" >Y-����</option>
            	    <option value="N" >N-������</option>
            	</select>
                <font class="orange">*</font>
            </td>
        </tr>
    </tbody>
    <tbody id="serverNo" name="serverNo" style="display:none">
        <tr>
            <td class="blue">��������</td>
            <td>
                <select name="serverNoNetAttr" id="serverNoNetAttr" disabled modifyFlag="Y" >
                    <wtc:qoption name="sPubSelect" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
                        <wtc:sql>select net_attr,net_attr||'->'||net_name from snetattr order by net_attr</wtc:sql>
                    </wtc:qoption>
                </select>
                <font class="orange">*</font>
            </td>
            <td class="blue">Ʒ��</td>
            <td>
                <select name="serverNoSmCode" id="serverNoSmCode" disabled modifyFlag="Y" >
                    <option value=""   >             </option>
                <%
        try
        {
            
            sql = "select a.sm_code, a.sm_name "
                + " from sSmCode a, sBusiTypeSmCode b "
                + " where a.sm_code = b.sm_code "
                + " and a.region_code = :regionCode";
            paraIn[0] = sql;    
            paraIn[1]="regionCode="+regionCode;
            %>
                <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode16" retmsg="retMsg16" outnum="2" >
                    <wtc:param value="<%=paraIn[0]%>"/>
                    <wtc:param value="<%=paraIn[1]%>"/> 
                </wtc:service>
                <wtc:array id="retArr16" scope="end"/>
            <%					
            //result = (String[][])retArray.get(0);
            if(retCode16.equals("000000")){
                result = retArr16;
            }
            int recordNum = result.length;
            for(int i=0;i<recordNum;i++)
            {
                out.println("<option class='button' value='" + result[i][0].trim() + "'");
                out.print(">" + result[i][1] + "</option>");
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        %>
    </select>
                <font class="orange">*</font>
            </td>
        </tr>
        <tr>        
            <td class="blue">�������󳤶�</td>
            <td>
                <input name="serverNoMaxLength" id="serverNoMaxLength" type="text" value="" class="InputGrey" readOnly />
            </td>
            <td class="blue">�������̳���</td>
            <td>
                <input name="serverNoMinLength" id="serverNoMinLength" type="text" value="" class="InputGrey" readOnly />
         </td>
        </tr>
        <tr>
            <td class="blue">�Ƿ�ȽϽ����</td>
            <td>
                <select name="serverNoAccessFlag" id="serverNoAccessFlag" disabled >
                    <option value=""   >             </option>
            	    <option value="Y" >Y-->�Ƚ�</option>
            	    <option value="N" >N-->���Ƚ�</option>
            	</select>
                <font class="orange">*</font>
            </td>
            <td class="blue">�Ƿ��жϷ���ų���</td>
            <td>
                <select name="serverNoLengthFlag" id="serverNoLengthFlag" disabled >
                    <option value=""   >             </option>
            	    <option value="Y" >Y-->�ж�</option>
            	    <option value="N" >N-->���ж�</option>
            	</select>
                <font class="orange">*</font>
            </td>
        </tr>
    </tbody>
    <tbody id="grpSmAttr" name="grpSmAttr" style="display:none">
    	<tr>
            <td class="blue">Ʒ�� </td>
            <td>
                <select name="grpSmAttrSmCode" id="grpSmAttrSmCode" disabled  >
                    <option value=""   >             </option>
                <%
        try
        {
            
            sql = "select a.sm_code, a.sm_name "
                + " from sSmCode a, sBusiTypeSmCode b "
                + " where a.sm_code = b.sm_code "
                + " and a.region_code = :regionCode";
            paraIn[0] = sql;    
            paraIn[1]="regionCode="+regionCode;
            %>
                <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode16" retmsg="retMsg16" outnum="2" >
                    <wtc:param value="<%=paraIn[0]%>"/>
                    <wtc:param value="<%=paraIn[1]%>"/> 
                </wtc:service>
                <wtc:array id="retArr16" scope="end"/>
            <%					
            //result = (String[][])retArray.get(0);
            if(retCode16.equals("000000")){
                result = retArr16;
            }
            int recordNum = result.length;
            for(int i=0;i<recordNum;i++)
            {
                out.println("<option class='button' value='" + result[i][0].trim() + "'");
                out.print(">" + result[i][1] + "</option>");
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        %>
    </select>
                <font class="orange">*</font>
            </td>
            <td class="blue">���Դ���</td>
            <td>
                <select name="grpSmAttrSmAttr" id="grpSmAttrSmAttr" disabled  >
                    <option value=""   >             </option>
            	    <option value="00" >00-->ҵ�����</option>
            	    <option value="01" >01-->ҵ������</option>
            	    <option value="02" >02-->�̺�Ψһ</option>
            	    <option value="03" >03-->�̺�����</option>
            	    <option value="04" >04-->�������ԱidΨһ</option>
            	    <option value="05" >05-->����ƽ̨����ԱidΨһ</option>
            	    <option value="06" >06-->apn�����</option>
            	    <option value="07" >07-->apn��Ψһ</option>
            	    <option value="08" >08-->apn������</option>
            	    <option value="09" >09-->vpmnһ�Զ������ж�</option>
            	</select>
                <font class="orange">*</font>
            </td>
        </tr>
        <tr>
            <td class="blue">�Ƿ�����</td>
            <td>
                <select name="grpSmAttrLimitFlag" id="grpSmAttrLimitFlag" disabled >
                    <option value=""  >        </option>
            	    <option value="Y" >Y-->�ж�</option>
            	    <option value="N" >N-->���ж�</option>
            	</select>
                <font class="orange">*</font>
            </td>
            <td class="blue">��������</td>
            <td>
                <select name="grpSmAttrDealType" id="grpSmAttrDealType" disabled >
                    <option value=""  >        </option>
            	    <option value="0" >0-->Ʒ�������ж�</option>
            	    <option value="1" >1-->Ʒ��ҵ�����</option>
            	</select>
                <font class="orange">*</font>
            </td>
        </tr>
        <tr>
        	<td class="blue">��������</td>
            <td>
                <select name="grpSmOpType" id="grpSmOpType" disabled >
                    <option value=""   >             </option>
                <%
        try
        {
            
            sql = "select op_type, type_name "
                + " from sgrpoptypecode ";

            paraIn[0] = sql;    

            %>       
               <wtc:pubselect name="sPubSelect"  retcode="retCode16" retmsg="retMsg16" outnum="2"  routerKey="region" routerValue="<%=regionCode%>">
                    <wtc:sql><%=sql%></wtc:sql>
                </wtc:pubselect>
                <wtc:array id="retArr16" scope="end"/>
            <%					
            //result = (String[][])retArray.get(0);
            if(retCode16.equals("000000")){
                result = retArr16;
            }
            int recordNum = result.length;
            for(int i=0;i<recordNum;i++)
            {
                out.println("<option class='button' value='" + result[i][0].trim() + "'");
                out.print(">" + result[i][1] + "</option>");
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        %>
    </select>
                <font class="orange">*</font>
            </td>
            <td class="blue">��������</td>
            <td>
                <input name="grpSmAttrName" id="grpSmAttrName" type="text" value="" class="InputGrey" readOnly />
            </td>
		</tr>
        <tr>
        	<td class="blue">ҵ����������</td>
            <td>
                <select name="grpSmAttrRequestType" id="grpSmAttrRequestType" disabled  >
                    <option value=""  >        </option>
            	    <option value="01" >01-->ͨ����</option>
            	    <option value="02" >02-->IPT��</option>
            	    <option value="03" >03-->��������</option>
            	    <option value="04" >04-->��������</option>      	    
            	</select>
            </td>
		</tr>
    </tbody>
    
    <tbody id="apnInfo" name="apnInfo" style="display:none">
    	<tr>
            <td class="blue">����</td>
            <td>
                <select name="apnInfoRegCode" id="apnInfoRegCode" disabled modifyFlag="Y" >
                    <option value=""   >             </option>
                <%
        try
        {
            
            sql = "select  region_code,region_name from sregioncode"
            	+" where use_flag='Y' and rownum<=13 order by region_code ";
                
            paraIn[0] = sql;   
            paraIn[1]="regionCode="+regionCode; 

            %>
                <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode16" retmsg="retMsg16" outnum="2" >
                    <wtc:param value="<%=paraIn[0]%>"/>
                    <wtc:param value=""/> 
                </wtc:service>
                <wtc:array id="retArr16" scope="end"/>
            <%					
            //result = (String[][])retArray.get(0);
            if(retCode16.equals("000000")){
                result = retArr16;
            }
            int recordNum = result.length;
            for(int i=0;i<recordNum;i++)
            {
                out.println("<option class='button' value='" + result[i][0].trim() + "'");
                out.print(">" + result[i][1] + "</option>");
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        %>
    </select>
                <font class="orange">*</font>
            </td>
            <td class="blue">Ʒ�� </td>
            <td>
                <select name="apnInfoSmCode" id="apnInfoSmCode" disabled modifyFlag="Y" >
                    <option value=""   >             </option>
                <%
        try
        {
            
            sql = "select a.sm_code, a.sm_name "
                + " from sSmCode a, sBusiTypeSmCode b "
                + " where a.sm_code = b.sm_code "
                + " and a.region_code = :regionCode";
            paraIn[0] = sql;    
            paraIn[1]="regionCode="+regionCode;
            %>
                <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode16" retmsg="retMsg16" outnum="2" >
                    <wtc:param value="<%=paraIn[0]%>"/>
                    <wtc:param value="<%=paraIn[1]%>"/> 
                </wtc:service>
                <wtc:array id="retArr16" scope="end"/>
            <%					
            //result = (String[][])retArray.get(0);
            if(retCode16.equals("000000")){
                result = retArr16;
            }
            int recordNum = result.length;
            for(int i=0;i<recordNum;i++)
            {
                out.println("<option class='button' value='" + result[i][0].trim() + "'");
                out.print(">" + result[i][1] + "</option>");
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        %>
    </select>
                <font class="orange">*</font>
            </td>
        </tr>
        <tr>
            <td class="blue">Apn ���� </td>
            <td>
				<input name="apnInfoApnCode" id="apnInfoApnCode"  v_type="0_9" value="" class="InputGrey" readOnly  />
                <font class="orange">*</font>
            </td>
            <td class="blue">Apn ID </td>
            <td>
				<input name="apnInfoApnId" id="apnInfoApnId" type="text" value="" class="InputGrey" readOnly  />
                <font class="orange">*</font>
            </td>
        </tr>
        <tr>
            <td class="blue">�ն�����</td>
            <td>
                <select name="apnInfoTermType" id="apnInfoTermType" disabled  >
                    <option value=""   >             </option>
                <%
        try
        {            
            sql = " select distinct a.terminal_type, a.terminal_name "
            	+ " from sTermType a,sregioncode b "
            	+ " where a.region_code =b.region_code and sm_code = 'ap' and valid_flag = 'Y' ";
				
            paraIn[0] = sql;    
            paraIn[1]="regionCode="+regionCode;
            %>
                <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode16" retmsg="retMsg16" outnum="2" >
                    <wtc:param value="<%=paraIn[0]%>"/>
                    <wtc:param value="<%=paraIn[1]%>"/> 
                </wtc:service>
                <wtc:array id="retArr16" scope="end"/>
            <%					
            //result = (String[][])retArray.get(0);
            if(retCode16.equals("000000")){
                result = retArr16;
            }
            int recordNum = result.length;
            for(int i=0;i<recordNum;i++)
            {
                out.println("<option class='button' value='" + result[i][0].trim() + "'");
                out.print(">" + result[i][1] + "</option>");
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        %>
    </select>
                <font class="orange">*</font>
            </td>
            <td class="blue">��������</td>
            <td>
                <select name="apnInfoRoamType" id="apnInfoRoamType" disabled  >
                    <option value=""   >             </option>
                <%
        try
        {
            
            sql = "select distinct a.roam_type, a.roam_name from sDdnRoamType a,sregioncode b"
            	+ " where a.region_code =b.region_code and a.sm_code='ap' and a.valid_flag = 'Y'";
                      
            paraIn[0] = sql;  
            paraIn[1]="regionCode="+regionCode;              
           
            %>
                <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode16" retmsg="retMsg16" outnum="2" >
                    <wtc:param value="<%=paraIn[0]%>"/>
                    <wtc:param value="<%=""%>"/> 
                </wtc:service>
                <wtc:array id="retArr16" scope="end"/>
            <%					
            //result = (String[][])retArray.get(0);
            if(retCode16.equals("000000")){
                result = retArr16;
            }
            int recordNum = result.length;
            for(int i=0;i<recordNum;i++)
            {
                out.println("<option class='button' value='" + result[i][0].trim() + "'");
                out.print(">" + result[i][1] + "</option>");
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        %>
    </select>
                <font class="orange">*</font>
            </td>
        </tr>
        <tr>
        	<td class="blue">�����ֶ�</td>
            <td>
                <input name="apnInfoOtherCode" id="apnInfoOtherCode" type="text" value="" class="InputGrey" readOnly  />                                          
            </td>
            <td class="blue">�Ƿ���Ч</td>
            <td>
                <select name="apnInfoValidFlag" id="apnInfoValidFlag" disabled >
                    <option value=""  >        </option>
            	    <option value="1" >Y-->��Ч</option>
            	    <option value="0" >N-->��Ч</option>
            	</select>
                <font class="orange">*</font>
            </td>
                                      
        </tr>
        <tr>
        	<td class="blue">ҵ���������� </td>
            <td>
                <select name="apnInfoRequestType" id="apnInfoRequestType" disabled  >
                    <option value=""  >        </option>
            	    <option value="01" >01-->ͨ����</option>
            	    <option value="02" >02-->IPT��</option>
            	    <option value="03" >03-->��������</option>
            	    <option value="04" >04-->��������</option>
            	</select>
            </td> 
            <td class="blue">��Ʒ������</td>             
            <td>
                <input name="apnInfoProSpecNo" id="apnInfoProSpecNo" type="text" value="" class="InputGrey" readOnly />

            </td>                  	
        </tr>
     </tbody>
</table>
<table cellspacing="0">
	<TR id="footer" align="center">
        <TD colspan="6">
            <input class="b_foot" name="addBtn"  type=button value="����"  onclick="addFunc()">
            <input class="b_foot" name="mdfBtn"  type=button value="�޸�"  onclick="modifyFunc()">
            <input class="b_foot" name="delBtn"  type=button value="ɾ��"  onclick="deleteFunc()">
            <input class="b_foot" name="sltBtn"  type=button value="��ѯ"  onclick="selectFunc()">
        </TD>
    </TR>
</table>
</div>

<div id="Operation_Table" style="display:">
<div class="title">
	<div id="title_zi">����Ϣչʾ</div>
</div>
<% if("grpSm".equals(iTableName)){ %>
<table cellspacing="0">
    <tbody id="grpSmList" name="grpSmList" style="display:">
        <tr>
            <th>&nbsp;</th>
            <th>&nbsp;&nbsp;Ʒ��</th>
            <th>&nbsp;&nbsp;�������</th>
            <th>&nbsp;&nbsp;����ֵ</th>
            <th>&nbsp;&nbsp;���Ʊ�־</th>
        </tr>

        <%for(int i=0;i<grpSmArr.length;i++){%>
        <%String tdClass = ((i%2)==1)?"Grey":"";%>
        <tr id="row<%=i%>" name="row<%=i%>" onClick="grpSmFocusFunc('<%=i%>')" class="blue">
            <td class='<%=tdClass%>'>
                <input type="checkbox" id="grpSmCheck" name="grpSmCheck" value="<%=i%>" disabled>
            </td>
            <td class='<%=tdClass%>'>
                <%=grpSmArr[i][0]%>
                <input type="hidden" id="grpSmSmCode<%=i%>" name="grpSmSmCode<%=i%>" value="<%=grpSmArr[i][0]%>">
            </td>
            <td class='<%=tdClass%>'>
                <%=grpSmArr[i][1]%>
                <input type="hidden" id="grpSmLimitType<%=i%>" name="grpSmLimitType<%=i%>" value="<%=grpSmArr[i][1]%>">
            </td>
            <td class='<%=tdClass%>'>
                <%=grpSmArr[i][2]%>
                <input type="hidden" id="grpSmLimitValue<%=i%>" name="grpSmLimitValue<%=i%>" value="<%=grpSmArr[i][2]%>">
            </td>
            <td class='<%=tdClass%>'>
                <%=grpSmArr[i][3]%>
                <input type="hidden" id="grpSmLimitFlag<%=i%>" name="grpSmLimitFlag<%=i%>" value="<%=grpSmArr[i][3]%>">
            </td>
        </tr>
        <%}%>
    </tbody>
</table>
<%}%>

<% if("serverNo".equals(iTableName)){ %>
<table cellspacing="0">
    <tbody id="serverNoList" name="serverNoList" style="display:">
        <tr>
            <th>&nbsp;</th>
            <th>&nbsp;&nbsp;��������</th>
            <th>&nbsp;&nbsp;Ʒ��</th>
            <th>&nbsp;&nbsp;�������󳤶�</th>
            <th>&nbsp;&nbsp;�������̳���</th>
            <th>&nbsp;&nbsp;�Ƿ�ȽϽ����</th>
            <th>&nbsp;&nbsp;�Ƿ��жϽ���ų���</th>
        </tr>
        <%for(int i=0;i<serverNoArr.length;i++){%>
        <%String tdClass = ((i%2)==1)?"Grey":"";%>
        <tr id="row<%=i%>" name="row<%=i%>" onClick="serverNoFocusFunc('<%=i%>')" class="blue">
            <td class='<%=tdClass%>'>
                <input type="checkbox" id="serverNoCheck" name="serverNoCheck" value="<%=i%>" disabled>
            </td>
            <td class='<%=tdClass%>'>
                <%=serverNoArr[i][0]%>
                <input type="hidden" id="serverNoNetAttr<%=i%>" name="serverNoNetAttr<%=i%>" value="<%=serverNoArr[i][0]%>">
            </td>
            <td class='<%=tdClass%>'>
                <%=serverNoArr[i][1]%>
                <input type="hidden" id="serverNoSmCode<%=i%>" name="serverNoSmCode<%=i%>" value="<%=serverNoArr[i][1]%>">
            </td>
            <td class='<%=tdClass%>'>
                <%=serverNoArr[i][2]%>
                <input type="hidden" id="serverNoMaxLength<%=i%>" name="serverNoMaxLength<%=i%>" value="<%=serverNoArr[i][2]%>">
            </td>
            <td class='<%=tdClass%>'>
                <%=serverNoArr[i][3]%>
                <input type="hidden" id="serverNoMinLength<%=i%>" name="serverNoMinLength<%=i%>" value="<%=serverNoArr[i][3]%>">
            </td>
            <td class='<%=tdClass%>'>
                <%=serverNoArr[i][4]%>
                <input type="hidden" id="serverNoAccessFlag<%=i%>" name="serverNoAccessFlag<%=i%>" value="<%=serverNoArr[i][4]%>">
            </td>
            <td class='<%=tdClass%>'>
                <%=serverNoArr[i][5]%>
                <input type="hidden" id="serverNoLengthFlag<%=i%>" name="serverNoLengthFlag<%=i%>" value="<%=serverNoArr[i][5]%>">
            </td>
        </tr>
        <%}%>
    </tbody>
</table>
<%}%>

<% if("grpSmAttr".equals(iTableName)){ %>
<table cellspacing="0">
    <tbody id="grpSmAttrList" name="grpSmAttrList" style="display:">
        <tr>
            <th>&nbsp;</th>
            <th>&nbsp;&nbsp;Ʒ��</th>
            <th>&nbsp;&nbsp;���Դ���</th>
            <th>&nbsp;&nbsp;�Ƿ�����</th>
            <th>&nbsp;&nbsp;��������</th>
            <th>&nbsp;&nbsp;��������</th>
            <th>&nbsp;&nbsp;��������</th>
            <th>&nbsp;&nbsp;ҵ����������</th>            
        </tr>
        <%for(int i=0;i<grpSmAttrArr.length;i++){%>
        <%String tdClass = ((i%2)==1)?"Grey":"";%>
        <tr id="row<%=i%>" name="row<%=i%>" onClick="grpSmAttrFocusFunc('<%=i%>')" class="blue">
            <td class='<%=tdClass%>'>
                <input type="checkbox" id="grpSmAttrCheck" name="grpSmAttrCheck" value="<%=i%>" disabled>
            </td>
            <td class='<%=tdClass%>'>
                <%=grpSmAttrArr[i][0]%>
                <input type="hidden" id="grpSmAttrSmCode<%=i%>" name="grpSmAttrSmCode<%=i%>" value="<%=grpSmAttrArr[i][0]%>">
            </td>
            <td class='<%=tdClass%>'>
                <%=grpSmAttrArr[i][1]%>
                <input type="hidden" id="grpSmAttrSmAttr<%=i%>" name="grpSmAttrSmAttr<%=i%>" value="<%=grpSmAttrArr[i][1]%>">
            </td>
            <td class='<%=tdClass%>'>
                <%=grpSmAttrArr[i][2]%>
                <input type="hidden" id="grpSmAttrLimitFlag<%=i%>" name="grpSmAttrLimitFlag<%=i%>" value="<%=grpSmAttrArr[i][2]%>">
            </td>
            <td class='<%=tdClass%>'>
                <%=grpSmAttrArr[i][3]%>
                <input type="hidden" id="grpSmAttrDealType<%=i%>" name="grpSmAttrDealType<%=i%>" value="<%=grpSmAttrArr[i][3]%>">
            </td>
            <td class='<%=tdClass%>'>
                <%=grpSmAttrArr[i][5]%>
                <input type="hidden" id="grpSmOpType<%=i%>" name="grpSmOpType<%=i%>" value="<%=grpSmAttrArr[i][5]%>">
            </td>
            <td class='<%=tdClass%>'>
                <%=grpSmAttrArr[i][4]%>
                <input type="hidden" id="grpSmAttrName<%=i%>" name="grpSmAttrName<%=i%>" value="<%=grpSmAttrArr[i][4]%>">
            </td>
            <td class='<%=tdClass%>'>
                <%=grpSmAttrArr[i][6]%>
                <input type="hidden" id="grpSmAttrRequestType<%=i%>" name="grpSmAttrRequestType<%=i%>" value="<%=grpSmAttrArr[i][6]%>">
            </td>            
        </tr>
        <%}%>
    </tbody>
</table>
<%}%>

<% if("apnInfo".equals(iTableName)){ %>
<table cellspacing="0">
    <tbody id="apnInfoList" name="apnInfoList" style="display:">
        <tr>
            <th>&nbsp;</th>
            <th>&nbsp;&nbsp;����</th>
            <th>&nbsp;&nbsp;Ʒ��</th>
            <th>&nbsp;&nbsp;apn����</th>
            <th>&nbsp;&nbsp;apn ID </th>
            <th>&nbsp;&nbsp;�ն�����</th>
            <th>&nbsp;&nbsp;��������</th>
            <th>&nbsp;&nbsp;�����ֶ�</th>
            <th>&nbsp;&nbsp;�Ƿ���Ч</th>
            <th>&nbsp;&nbsp;ҵ����������</th> 
            <th>&nbsp;&nbsp;��Ʒ������</th>            
        </tr>
        
        <%for(int i=0;i<apnInfoArr.length;i++){%>
        <%String tdClass = ((i%2)==1)?"Grey":"";%>
        <tr id="row<%=i%>" name="row<%=i%>" onClick="apnInfoFocusFunc('<%=i%>')" class="blue">
            <td class='<%=tdClass%>'>
                <input type="checkbox" id="apnInfoCheck" name="apnInfoCheck" value="<%=i%>" disabled>
            </td>
            <td class='<%=tdClass%>'>
                <%=apnInfoArr[i][0]%>
                <input type="hidden" id="apnInfoRegCode<%=i%>" name="apnInfoRegCode<%=i%>" value="<%=apnInfoArr[i][0]%>">
            </td>
            <td class='<%=tdClass%>'>
                <%=apnInfoArr[i][1]%>
                <input type="hidden" id="apnInfoSmCode<%=i%>" name="apnInfoSmCode<%=i%>" value="<%=apnInfoArr[i][1]%>">
            </td>
            <td class='<%=tdClass%>'>
                <%=apnInfoArr[i][2]%>
                <input type="hidden" id="apnInfoApnCode<%=i%>" name="apnInfoApnCode<%=i%>" value="<%=apnInfoArr[i][2]%>">
            </td>
            <td class='<%=tdClass%>'>
                <%=apnInfoArr[i][3]%>
                <input type="hidden" id="apnInfoApnId<%=i%>" name="apnInfoApnId<%=i%>" value="<%=apnInfoArr[i][3]%>">
            </td>
            <td class='<%=tdClass%>'>
                <%=apnInfoArr[i][4]%>
                <input type="hidden" id="apnInfoTermType<%=i%>" name="apnInfoTermType<%=i%>" value="<%=apnInfoArr[i][4]%>">
            </td>
            <td class='<%=tdClass%>'>
                <%=apnInfoArr[i][5]%>
                <input type="hidden" id="apnInfoRoamType<%=i%>" name="apnInfoRoamType<%=i%>" value="<%=apnInfoArr[i][5]%>">
            </td>
            <td class='<%=tdClass%>'>
                <%=apnInfoArr[i][6]%>
                <input type="hidden" id="apnInfoOtherCode<%=i%>" name="apnInfoOtherCode<%=i%>" value="<%=apnInfoArr[i][6]%>">
            </td> 
            <td class='<%=tdClass%>'>
                <%=apnInfoArr[i][7]%>
                <input type="hidden" id="apnInfoValidFlag<%=i%>" name="apnInfoValidFlag<%=i%>" value="<%=apnInfoArr[i][7]%>">
            </td>
            <td class='<%=tdClass%>'>
                <%=apnInfoArr[i][8]%>
                <input type="hidden" id="apnInfoRequestType<%=i%>" name="apnInfoRequestType<%=i%>" value="<%=apnInfoArr[i][8]%>">
            </td>
            <td class='<%=tdClass%>'>
                <%=apnInfoArr[i][9]%>
                <input type="hidden" id="apnInfoProSpecNo<%=i%>" name="apnInfoProSpecNo<%=i%>" value="<%=apnInfoArr[i][9]%>">
            </td>                        
        </tr>
        <%}%>
    </tbody>
</table>
<%}%>

<table cellSpacing="0" id="pageDis" style="display:
	<%
	if((Integer.parseInt(allNumStr[0][0]))<=iPageSize){
		out.println(" none ");
	}
	%>
	">
    <tr>
        <td align=center>
<%	
    int iQuantity = Integer.parseInt(allNumStr[0][0].trim());
    Page pg = new Page(iPageNumber,iPageSize,iQuantity);
	PageView view = new PageView(request,out,pg); 
   	view.setVisible(true,true,0,0);       
%>
</td>
</tr>
</table>


<table cellspacing="0">
	<TR id="footer" align="center">
        <TD colspan="6">
            <input class="b_foot" name="sureBtn"  type=button value="ȷ��"  onclick="refMain()" disabled >
            <input class="b_foot" name="closeBtn"  type=button value="�ر�"  onClick="removeCurrentTab()" >
        </td>
    </tr>
</table>

<input type="hidden" name="row_no" id="row_no" value="" />
<input type="hidden" name="opType" id="opType" value="" />
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>