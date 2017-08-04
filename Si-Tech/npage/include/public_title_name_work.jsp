<%
    /* BEGIN : add by qidp for 系统换肤 @ 2010-04-19 */
    String versonType = WtcUtil.repNull((String)session.getAttribute("versonType"));    // 页面框架版本:: normal:普通版;simple:高速版.
    System.out.println("$ versonType = "+versonType);
    
    String cssPath = "default";
    if(!"simple".equals(versonType)){
        cssPath = WtcUtil.repNull((String)session.getAttribute("cssPath"));  // 系统皮肤
    }
    System.out.println("$ css path is : "+cssPath);
    /* END : add by qidp */
%>

<link href="/nresources/<%=cssPath%>/css/FormText.css" rel="stylesheet" type="text/css"></link>
<link href="/nresources/<%=cssPath%>/css/font_color.css" rel="stylesheet" type="text/css"></link>
<link href="/nresources/<%=cssPath%>/css/ValidatorStyle.css" rel="stylesheet" type="text/css"></link>
<link href="/nresources/<%=cssPath%>/css/prompt.css" rel="stylesheet" type="text/css"></link>

<script type="text/javascript" src="/njs/extend/jquery/tooltip/jquery.tooltip.js"></script>	
<link href="/njs/extend/jquery/tooltip/jquery.tooltip.css" rel="stylesheet" type="text/css"></link>