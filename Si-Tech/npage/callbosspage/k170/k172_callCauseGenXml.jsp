<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="import java.net.URLDecoder"%>
<%@ page import="import com.sitech.crmpd.kf.ejb.client.KFEjbClient"%>
<%@ page import="import com.sitech.crmpd.kf.ejb.KFBusi"%>
<%@ page import="import com.sitech.crmpd.kf.dto.causetree.Dcallcausecfg"%>
<%@ page import="import org.jdom.*"%>
<%@ page import="import java.io.*"%>
<%@ page import="import org.jdom.input.*"%>
<%@ page import="import org.jdom.output.*"
	import="org.apache.commons.io.FileUtils"%>

<%!
public String getblank(int num)
{
	String str="";
	
	for(int i=0;i<num;i++)
	{
		str+="";
	}
	
	return str;
}
%>
<%
/*
  modify by yinzx 20090922 ���շ�Բ�޸ġ�
*/

//yanghy 20090916 ��дֱ������html �ĺ���.###########BEGIN.
StringBuffer outHTML = new StringBuffer();
//����html��ʽ.
outHTML.append("<");
outHTML.append("%");
outHTML.append("@");
outHTML.append(" page contentType=\"text/html;charset=GBK\"");
outHTML.append("%");
outHTML.append(">\n");//����jsp��ͷ����.û�����������.
outHTML.append("<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n");
outHTML.append("<html>\n");
outHTML.append("<head>\n");
outHTML.append("<meta http-equiv='Content-Type' content='text/html; charset=GBK'>\n");//���ñ����ʽ.
outHTML.append("<meta http-equiv='Cache-Control' content='no-store' />\n");//���ñ����ʽ.
outHTML.append("<meta http-equiv='Pragma' content='no-cache' />\n");//�޻�������
outHTML.append("<meta http-equiv='Expires' content='0' />\n");//�޻�������
outHTML.append("<script src='"+request.getContextPath()+"/njs/extend/jquery/jquery123_pack.js' type=text/javascript></script>\n");
//���ù�˾js
outHTML.append("<link href='./show_menu.css' rel='stylesheet' type='text/css' />\n");
//������ʽ��.�Բ˵�������Ⱦ.
outHTML.append("</head><body>\n");
List list_html = null;
int i_node = 1;//�������Ľڵ���.
//yanghy 20090916 ��дֱ������html �ĺ���.###########END



Element rootElement = new Element("note");
Element rootSeachElement = new Element("note");
//String datea =(String)KFEjbClient.queryForObject("getSysdate");

Dcallcausecfg dcc = new Dcallcausecfg();
java.util.List list = null;
list = KFEjbClient.queryForList("queryDcallcausecfg", dcc);

int levelsplitnum=3; //��ηָ��С
int i=0,j=0,tmp=0,n=0,trnum=0;
Element firstElement = new Element("firstlevel");
Element secondeElement = new Element("secondelevel");
String datastr ="";
String tmp_super_id="";
 for(Iterator it = list.iterator(); it.hasNext();)
{

	Dcallcausecfg dcc1 = (Dcallcausecfg)it.next();
	System.out.println(dcc1.getCaption());
  System.out.println(dcc1.getSuper_id());
	if(dcc1.getSuper_id().equals("0"))
	{
	 if(i!=0)
	 {
	  if(n != 0){
	 		datastr+="</table>";
			Text text=new Text(datastr); 
			secondeElement.addContent(text);
		}
		firstElement.addContent(secondeElement);
		secondeElement = new Element("secondelevel");
	 	rootElement.addContent(firstElement);
	 	firstElement = new Element("firstlevel");
	 	datastr="";
	 	j=tmp=n=0;
	 }	
		firstElement.setAttribute(new Attribute("CALLCAUSE_ID", dcc1.getCallcause_id()));
		firstElement.setAttribute(new Attribute("SUPER_ID", dcc1.getSuper_id()));
		firstElement.setAttribute(new Attribute("CAPTION", dcc1.getCaption()));
		firstElement.setAttribute(new Attribute("FULLNAME", dcc1.getFullname()));
		i++;
		
		
		//yanghy 20090916 ��дֱ������html �ĺ���
		//�ҵ����ڵ�.
		if(i_node != 0){
			outHTML.append("</div>");//������һ���ڵ�Ľ���.
		}
		outHTML.append("<div id=Operation_Table><div class=bar><div class=title>");//����һ���ڵ�.
		outHTML.append(dcc1.getCaption());
		outHTML.append("</div></div>\n");
		i_node ++;
		//yanghy 20090916 ��дֱ������html �ĺ���END
		
		
	}else if(dcc1.getSuper_id().length()==levelsplitnum ){
		j++;
		if(tmp < j && j != 1 && n!=0)
		{
			datastr+="</table>";
			Text text=new Text(datastr); 
			secondeElement.addContent(text);
			firstElement.addContent(secondeElement);
			secondeElement = new Element("secondelevel");
			datastr="";
			n=0;
			tmp=j;
		}else if(tmp < j && j != 1 && n==0)
		{
			firstElement.addContent(secondeElement);
			secondeElement = new Element("secondelevel");
			datastr="";
			n=0;
		}else
			tmp=j;
		secondeElement.setAttribute(new Attribute("CALLCAUSE_ID", dcc1.getCallcause_id()));
		secondeElement.setAttribute(new Attribute("SUPER_ID", dcc1.getSuper_id()));
		secondeElement.setAttribute(new Attribute("CAPTION", dcc1.getCaption()));
		secondeElement.setAttribute(new Attribute("FULLNAME", dcc1.getFullname()));
		
		
		//yanghy 20090916 ��дֱ������html �ĺ���BEGIN
		//�ҵ��ڶ����ڵ�.���������.//
		outHTML.append("<div class=tree id=");
		outHTML.append(dcc1.getCallcause_id());
		outHTML.append(" style='display: none' onclick='getdetail(this);' onmouseover='changecolor(this);' onmouseout='changecolor(this);' >");
		outHTML.append(dcc1.getCaption());
		outHTML.append("</div>\n");
		//yanghy 20090916 ��дֱ������html �ĺ���END
		
		
	}else if( dcc1.getSuper_id().length() > levelsplitnum )
	{
		if(dcc1.getSuper_id().length()== 2*levelsplitnum && n == 0)
		{
		  
			if(dcc1.getIs_leaf().equals("0"))
			{
				datastr="<table><tr><td class='Grey' colspan='2' showflag='0' id='td"+dcc1.getCallcause_id()+"' onclick='levelclick(this)'>"+getblank(dcc1.getSuper_id().length()/levelsplitnum)+"<img src='/nresources/default/images/mztree/fopen.gif' >"+dcc1.getCaption()+"</td></tr>";
				trnum=0;
			}
			else
			{
				datastr="<table><tr><td class='Blue"+dcc1.getSuper_id().length()/levelsplitnum+"' id='td"+dcc1.getCallcause_id()+"'>"+getblank(dcc1.getSuper_id().length()/levelsplitnum)+"<input type='checkbox' id='chk"+dcc1.getCallcause_id()+"' fullname='"+dcc1.getFullname()+"' onclick='checkin(this)'/><a href='javascript:void(0)'><span     onclick='checkinDesc(this)' >"+dcc1.getCaption()+"</span></a></td>";
				trnum++;
				Element itemSeachElement = new Element("itemSeach");
				itemSeachElement.setAttribute(new Attribute("CALLCAUSE_ID", dcc1.getCallcause_id()));
				itemSeachElement.setAttribute(new Attribute("SUPER_ID", dcc1.getSuper_id()));
				itemSeachElement.setAttribute(new Attribute("CAPTION", dcc1.getCaption()));
				itemSeachElement.setAttribute(new Attribute("FULLNAME", dcc1.getFullname()));
				itemSeachElement.addContent(new Text("<input type='checkbox' id='chk"+dcc1.getCallcause_id()+"' fullname='"+dcc1.getFullname()+"' onclick='checkin(this)'/> "));
				rootSeachElement.addContent(itemSeachElement);
			}
			n++;
		}else
		{
			if(dcc1.getIs_leaf().equals("0"))
			{  
			    if(dcc1.getSuper_id().length()== 2*levelsplitnum )
		    {
				   datastr+="<tr><td class='Grey' colspan='2' showflag='0' id='td"+dcc1.getCallcause_id()+"' onclick='levelclick(this)'>"+getblank(dcc1.getSuper_id().length()/levelsplitnum)+"<img src='/nresources/default/images/mztree/fopen.gif' >"+dcc1.getCaption()+"</td></tr>";
				   trnum=0;
				}else
				{
				   
				   datastr+="<tr><td class='Grey1' colspan='2' showflag='0' id='td"+dcc1.getCallcause_id()+"' onclick='levelclick(this)'>"+getblank(dcc1.getSuper_id().length()/levelsplitnum)+"<img src='/nresources/default/images/mztree/fopen.gif' >"+dcc1.getCaption()+"</td></tr>";
				   trnum=0;
				}
				 	
			}
			else
			{
				if(trnum == 0){
					datastr+="<tr>";
					datastr+="<td class='Blue"+dcc1.getSuper_id().length()/levelsplitnum+"' id='td"+dcc1.getCallcause_id()+"'>"+getblank(dcc1.getSuper_id().length()/levelsplitnum)+"<input type='checkbox' id='chk"+dcc1.getCallcause_id()+"' fullname='"+dcc1.getFullname()+"' onclick='checkin(this)'/><a href='javascript:void(0)' ><span     onclick='checkinDesc(this)' >"+dcc1.getCaption()+"</span></a></td>";
					trnum++;
					Element itemSeachElement = new Element("itemSeach");
					itemSeachElement.setAttribute(new Attribute("CALLCAUSE_ID", dcc1.getCallcause_id()));
					itemSeachElement.setAttribute(new Attribute("SUPER_ID", dcc1.getSuper_id()));
					itemSeachElement.setAttribute(new Attribute("CAPTION", dcc1.getCaption()));
					itemSeachElement.setAttribute(new Attribute("FULLNAME", dcc1.getFullname()));
					itemSeachElement.addContent(new Text("<input type='checkbox' id='chk"+dcc1.getCallcause_id()+"' fullname='"+dcc1.getFullname()+"' onclick='checkin(this)'/>  "));
					rootSeachElement.addContent(itemSeachElement);
					}
				else{
					if(tmp_super_id.length() == dcc1.getSuper_id().length())
					{
						datastr+="<td class='Blue"+dcc1.getSuper_id().length()/levelsplitnum+"' id='td"+dcc1.getCallcause_id()+"'>"+getblank(dcc1.getSuper_id().length()/levelsplitnum)+"<input type='checkbox' id='chk"+dcc1.getCallcause_id()+"' fullname='"+dcc1.getFullname()+"' onclick='checkin(this)'/><a href='javascript:void(0)'><span     onclick='checkinDesc(this)' >"+dcc1.getCaption()+"</span></a></td>";
						datastr+="</tr>";
						trnum=0;
					Element itemSeachElement = new Element("itemSeach");
					itemSeachElement.setAttribute(new Attribute("CALLCAUSE_ID", dcc1.getCallcause_id()));
					itemSeachElement.setAttribute(new Attribute("SUPER_ID", dcc1.getSuper_id()));
					itemSeachElement.setAttribute(new Attribute("CAPTION", dcc1.getCaption()));
					itemSeachElement.setAttribute(new Attribute("FULLNAME", dcc1.getFullname()));
					itemSeachElement.addContent(new Text("<input type='checkbox' id='chk"+dcc1.getCallcause_id()+"' fullname='"+dcc1.getFullname()+"' onclick='checkin(this)'/>  "));
					rootSeachElement.addContent(itemSeachElement);
					}else
					{
						datastr+="</tr>";
						datastr+="<tr>";
						datastr+="<td class='Blue"+dcc1.getSuper_id().length()/levelsplitnum+"' id='td"+dcc1.getCallcause_id()+"'>"+getblank(dcc1.getSuper_id().length()/levelsplitnum)+"<input type='checkbox' id='chk"+dcc1.getCallcause_id()+"' fullname='"+dcc1.getFullname()+"' onclick='checkin(this)'/><a href='javascript:void(0)' ><span     onclick='checkinDesc(this)' >"+dcc1.getCaption()+"</span></a></td>";
						trnum++;
					Element itemSeachElement = new Element("itemSeach");
					itemSeachElement.setAttribute(new Attribute("CALLCAUSE_ID", dcc1.getCallcause_id()));
					itemSeachElement.setAttribute(new Attribute("SUPER_ID", dcc1.getSuper_id()));
					itemSeachElement.setAttribute(new Attribute("CAPTION", dcc1.getCaption()));
					itemSeachElement.setAttribute(new Attribute("FULLNAME", dcc1.getFullname()));
					itemSeachElement.addContent(new Text("<input type='checkbox' id='chk"+dcc1.getCallcause_id()+"' fullname='"+dcc1.getFullname()+"'onclick='checkin(this)'/> "));
					rootSeachElement.addContent(itemSeachElement);
					}
				}
			}
		}
	}
	//System.out.println(supId);
	tmp_super_id=dcc1.getSuper_id();
}
	  if(n != 0){
	 		datastr+="</table>";
			Text text=new Text(datastr); 
			secondeElement.addContent(text);
		}
		firstElement.addContent(secondeElement);
		secondeElement = new Element("secondelevel");
	 	rootElement.addContent(firstElement);
Document doc = new Document(rootElement);      
Document seachdoc = new Document(rootSeachElement);
XMLOutputter outputter = new XMLOutputter(" ", true,"gb2312"); 
XMLOutputter seachoutputter = new XMLOutputter(" ", true,"gb2312");
outputter.output(doc, new FileWriter("/kfweb/applications/DefaultWebApp/file/callcenter/callreson.xml")); 
outputter.output(seachdoc, new FileWriter("/kfweb/applications/DefaultWebApp/file/callcenter/callresonseach.xml")); 


//yanghy 20090916 ��дֱ������html �ĺ���.###########BEGIN.
outHTML.append("</div>");
outHTML.append("<script src='./show_menu.js' type=text/javascript></script>");
//show_menu.js jquery ��ʾ�ӽڵ㺯��.�ͶԵ����Ӧ�¼��Ĵ���.
outHTML.append("</body></html>");
//out.println(outHTML.toString());
FileUtils.writeStringToFile(new File("/kfweb/applications/DefaultWebApp/npage/callbosspage/k170/callcomereasonemenus.jsp"),outHTML.toString(),"GBK");
//����ļ���ָ��Ŀ¼����.��html�ļ�����GBK.

//yanghy 20090916 ��дֱ������html �ĺ���.###########END.


%>

var response = new AJAXPacket();
core.ajax.receivePacket(response);