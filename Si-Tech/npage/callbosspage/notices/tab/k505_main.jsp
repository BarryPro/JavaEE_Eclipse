<%@ page contentType="text/html;charset=GBK"%>
<%
  /*
   * ����: "����鿴"��תҳ�棬ʹ���ڹ������ı�ǩ�����д�
�� * �汾: 1.0.0
�� * ����: 2010/09/13
�� * ����: tangsong
�� * ��Ȩ: sitech
�� */
%>
<%
  String uri = request.getParameter("uri");
  uri = new String(uri.getBytes("GBK"),"UTF-8");
%>

<script type="text/javascript">
	window.location.href = decodeURIComponent("<%=uri%>");
</script>