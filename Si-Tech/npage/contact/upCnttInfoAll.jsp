<%
/*
�Ӵ���¼����
shibc
20080701

����Ҫ��ɵĹ�����
TODO:��ѯ�û�id�����Ŀͻ������һ�����¼ �����½Ӵ�
TODO:sessionʧЧ��ʱ��ر����һ�νӴ�

ʹ�÷�ʽ��
String url = "/npage/contact/upCnttInfo.jsp?opCode=1302&opName=�ɷ�&workNo=shibc&retCodeForCntt=000000&loginAccept=1111&pageActivePhone=&contactId=13330002323&contactType=user";
<jsp:include page=url flush="true" />

������ΰҪ�����Ӳ�����֯���룺
retMsgForCntt :���񷵻���Ϣ
opBeginTime��ҵ�����ʼʱ��

���������
opCode����������
opName����������
workNo������Ա
retCodeForCntt�����񷵻�ֵ
loginAccept �����񷵻���ˮ
pageActivePhone ������tab��ʱ�������ֻ�����
contactType ���Ӵ��������� user cust acc grp
contactId���Ӵ�����id
���ȼ���
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
	
	//�Ӵ�ƽ̨״̬
  String appCnttFlag = (String)application.getAttribute("appCnttFlag"); 
  if("Y".equals(appCnttFlag)){
%>

<%
//��ȡ��ˮ��
if(loginAccept==null||"".equals(loginAccept)||"null".equals(loginAccept.toLowerCase())){
%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept"  id="cnttLoginAccept"/>
<%
	loginAccept=cnttLoginAccept;
}
	//��ʼ����ǰsession��Ϣ ��¼��ǰ�ĽӴ�id������
	
	//�����û�(�ֻ�����)���ʻ����ͻ�
	String _lastCurrentContactType = (String)session.getAttribute("_lastCurrentContactType");
	if(_lastCurrentContactType==null) _lastCurrentContactType="init";
	//������͵�id
	String _lastCurrentContactId = (String)session.getAttribute("_lastCurrentContactId");
	if(_lastCurrentContactId==null) _lastCurrentContactId="init";
	
	//��ʼ����ʼ��Ϣ ��������Ϣ��ȡ����
	String _sessionActivePhone = (String)session.getAttribute("activePhone");//��ǰ��Щ�ļ������
	String _pageActivePhone = request.getParameter("pageActivePhone");//���û������������һ��tab
  //System.out.println("_pageActivePhone==="+_pageActivePhone);
	
	//��̬��ʼ��������Ϣ ��Ҫ�޸� ��ҪopCode���� ���������ã��޸ĳɲ�������
	//contactType (�û�user �ͻ� cust �ʻ� acc ���� grp) 
	//contactId ��Ӧ�ĽӴ�����ĺ���id

	String _pageContactId = request.getParameter("contactId");
	//��request��ȡ�Ӵ�id���û�user �ͻ� cust �ʻ� acc
	//0-�ͻ���1-�û���2-�ʻ���3-���ſͻ���ʶ

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

	//��ǰ�ĽӴ�����id
	String _currentContactType = null;
	String _currentContactId = null;
	
	//�Ƿ�ʹ���µĽӴ�����滻�ɵģ��滻���ܳ�����Ϣ�Ľ����Ͷ�ʧ
	boolean _replaceFlag = true;
	//�Ƿ����½Ӵ�
	boolean _isNewContact = true;
	//�Ƿ��¼�Ӵ���Ϣ
	boolean _isRecord = true;
	
	//��һ�νӴ���ˮ, �����Ӵ�ID --liubo��
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
		//�޷���ȡ�Ӵ���Ϣ
		_currentContactId = "";
		_currentContactType = "";
	}
	
	//��ʼ�����ں��ж�
	if(_currentContactId.equals(""))
	{
			//��ǰ�Ӵ�ֵ���Ϸ�����ֱ������
			_replaceFlag=true;
			_isNewContact=true;
			_isRecord=false;
	}
	else
	{
		if(_currentContactType.equals("1"))
		{
			//��¼�û���Ϣ
	
			if(_lastCurrentContactType.equals("1"))
			{
				if(_currentContactId.equals(_lastCurrentContactId))
				{
					//��¼�Ӵ���Ϣ
					_replaceFlag=false;
					_isNewContact=false;
					_isRecord=true;
				}
				else
				{
					//��¼�Ӵ���Ϣ
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
					//�����½Ӵ�
					_replaceFlag=true;
					_isNewContact=true;
					_isRecord=true;
					
			}else
			{
			   //�����½Ӵ�
					_replaceFlag=true;
					_isNewContact=true;
					_isRecord=true;
			}
	
			
		}else if(_currentContactType.equals("0"))
		{
			//��¼�ͻ���Ϣ
			if(_lastCurrentContactType.equals("1"))
			{
				//TODO:��ѯ�û�id�����Ŀͻ������һ�����¼ �����½Ӵ�
				
					_replaceFlag=true;
					_isNewContact=true;
					_isRecord=true;
					//-------- begin of ��ʼ�жϿͻ����û������ ------------------------------
					try{
%>
	<wtc:pubselect name="sPubSelect" outnum="1">
		<wtc:sql> select cust_id from dcustmsg where phone_no='?' </wtc:sql>
	  <wtc:param value="<%=_currentContactId%>"/> 
	</wtc:pubselect>
	<wtc:array id="rows"  scope="end"/>
<%
	  	if(!retCode.equals("000000")){
				System.out.println("sPubSelect��ѯ����"+retCode);
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
			   				//�̳�ԭ���ĽӴ�
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
					//-------------end of ��ʼ�жϿͻ����û������ ------------------------
				
			}else if(_lastCurrentContactType.equals("0"))
			{
	
				if(_currentContactId.equals(_lastCurrentContactId))
				{
					//��¼�Ӵ���Ϣ
					_replaceFlag=false;
					_isNewContact=false;
					_isRecord=true;
				}
				else
				{
					//��¼�Ӵ���Ϣ
					_replaceFlag=true;
					_isNewContact=true;
					_isRecord=true;
				}
			
			}else if(_lastCurrentContactType.equals("2"))
			{
					//�����½Ӵ�
					_replaceFlag=true;
					_isNewContact=true;
					_isRecord=true;
					
			}else
			{
			   //�����½Ӵ�
					_replaceFlag=true;
					_isNewContact=true;
					_isRecord=true;
			}

		}else if(_currentContactType.equals("2"))
		{
			//��¼�ʻ��Ӵ���Ϣ
			if(_lastCurrentContactType.equals("1"))
			{
					_replaceFlag=true;
					_isNewContact=true;
					_isRecord=true;
				
			}else if(_lastCurrentContactType.equals("0"))
			{
			   //�����½Ӵ�
					_replaceFlag=true;
					_isNewContact=true;
					_isRecord=true;
			
			}else if(_lastCurrentContactType.equals("2"))
			{
	
				if(_currentContactId.equals(_lastCurrentContactId))
				{
					//��¼�Ӵ���Ϣ
					_replaceFlag=false;
					_isNewContact=false;
					_isRecord=true;
				}
				else
				{
					//��¼�Ӵ���Ϣ
					_replaceFlag=true;
					_isNewContact=true;
					_isRecord=true;
				}
					
			}else
			{
			   //�����½Ӵ�
					_replaceFlag=true;
					_isNewContact=true;
					_isRecord=true;
			}
			
		}else
		{
			//����¼�Ӵ���Ϣ
					_replaceFlag=true;
					_isNewContact=true;
					_isRecord=false;
		}
	}

System.out.println("--------begin �Ӵ���Ϣ ----------");
System.out.println("--------_replaceFlag ----------"+_replaceFlag);
System.out.println("--------_isNewContact ----------"+_isNewContact);
System.out.println("--------_isRecord ----------"+_isRecord);
System.out.println("--------end �Ӵ���Ϣ----------");

//��ʼ��¼�Ӵ���Ϣ
if(_isRecord)
{
	if(_isNewContact)
	{
		//�½Ӵ���ʼ �ر���һ�Σ��������νӴ�
		if(!_lastCurrentContactType.equals("init"))
		{
			//TODO:sessionʧЧ��ʱ��ر����һ�νӴ�
			//----------------------------------------begin of �ر��ϴνӴ�---------------------------------------
			
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
					System.out.println("sEndCntt��¼�Ӵ�����:"+retCode);
			   }
				}catch(Throwable e)
				{
				
				}
			}
			//----------------------------------------end of �ر��ϴνӴ�-----------------------------------------
		}
		
		//------------------------------------begin of ��¼��ǰ�Ӵ�----------------------------------------------
    //�Ӵ�ƽ̨״̬
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
		  		//������һ�νӴ���ˮ
		     	 session.setAttribute("_lastContactSeq",rows[0][0]);
			   }
			   else
			   {
			   	System.out.println("sInitCntt��¼�Ӵ�����:"+retCode);
			   }
	    }catch(Throwable e)
	    {
	    }
		//------------------------------------end of ��¼��ǰ�Ӵ�---------------------------------------
		
	}

		System.out.println("--------_lastContactSeq��ˮ:"+session.getAttribute("_lastContactSeq"));
		_lastContactSeq = (String)session.getAttribute("_lastContactSeq");

		//-------------------------------------begin of ��¼��ǰҵ��Ӵ�----------------------------
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
					System.out.println("sUpCnttInfo��¼�Ӵ�����:"+retCode);
			   }
	    }catch(Throwable e)
	    {
	    }
		//-------------------------------------end of ��¼��ǰҵ��Ӵ� ---------------------------- 

}

//�滻�ɵĽӴ���Ϣ
if(_replaceFlag)
{
	session.setAttribute("_lastCurrentContactType",_currentContactType);
	session.setAttribute("_lastCurrentContactId",_currentContactId);
}

}
%>
