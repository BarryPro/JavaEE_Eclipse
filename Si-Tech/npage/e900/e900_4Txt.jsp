<%
response.setContentType("text/plain;charset=GBK");
response.setHeader("Content-disposition","attachment; filename=table.txt");

String taxpay_code = (String)request.getAttribute("taxpay_code");
String taxpay_name = (String)request.getAttribute("taxpay_name");
String year = (String)request.getAttribute("year");
String jd = (String)request.getAttribute("jd");
String zbr = (String)request.getAttribute("zbr");
String shr = (String)request.getAttribute("shr");
String jsr = (String)request.getAttribute("jsr");
String date = (String)request.getAttribute("date");
java.text.SimpleDateFormat formatDate = new java.text.SimpleDateFormat("yyyyMMdd");
java.text.SimpleDateFormat formatDate1 = new java.text.SimpleDateFormat("yyyy-MM-dd");
date=formatDate1.format(formatDate.parse(date));

String result[][] = (String[][])request.getAttribute("result");


out.print(taxpay_name+"\t");
out.print(taxpay_code+"\t");
out.print(year+"\t");
out.print(jd+"\t");
out.print(" \t");
out.print(zbr+"\t");
out.print(shr+"\t");
out.print(date);

//response.getWriter().write("\r\n"); 

 

/*
out.print("序号\t");
out.print("用票单位名称\t");
out.print("发票代码\t");
out.print("上期结存册数\t");
out.print("上期结存份数\t");
out.print("领购册数\t");
out.print("领购份数\t");
out.print("使用册数\t");
out.print("使用份数\t");
out.print("结存册数\t");
out.print("结存份数\t");
out.print("开具金额\t");

response.getWriter().write("\r\n"); 
*/
int count=1;
for(int i=0;i<result.length;i++)
{
	response.getWriter().write("\r\n");
	out.print(count+"");
	out.print("\t");	
	out.print(result[i][2]);
	out.print("\t");
	out.print(result[i][3]);
	out.print("\t");
	out.print(result[i][4]);
	out.print("\t");
	out.print(result[i][5]);
	out.print("\t");
	out.print(result[i][6]);
	out.print("\t");
	out.print(result[i][7]);
	out.print("\t");
	out.print(result[i][8]);
	out.print("\t");
	out.print(result[i][9]);
	out.print("\t");
	out.print(result[i][10]);
	out.print("\t");
	out.print(result[i][11]);
	out.print("\t");
	out.print(result[i][12]);
	count++; 
}	
/*
String text = "";
int count=1;
for(int i=0;i<result.length;i++)
{
    text = count+"";
    while(text.length()<12)
   {
      text+=" ";
   }
	out.print(text);	
	text = result[i][2];
    while(text.length()<14)
   {
      text+=" ";
   }
	out.print(text);
	text = result[i][3];
    while(text.length()<14)
   {
      text+=" ";
   }
	out.print(text);
	text = result[i][4];
    while(text.length()<13)
   {
      text+=" ";
   }
	out.print(text);
	text = result[i][5];
    while(text.length()<13)
   {
      text+=" ";
   }
	out.print(text);
	text = result[i][6];
    while(text.length()<12)
   {
      text+=" ";
   }
	out.print(text);
	text = result[i][7];
    while(text.length()<12)
   {
      text+=" ";
   }
	out.print(text);
	text = result[i][8];
    while(text.length()<11)
   {
      text+=" ";
   }
	out.print(text);
	text = result[i][9];
    while(text.length()<11)
   {
      text+=" ";
   }
	out.print(text);
	text = result[i][10];
    while(text.length()<11)
   {
      text+=" ";
   }
	out.print(text);
	text = result[i][11];
    while(text.length()<12)
   {
      text+=" ";
   }	
	out.print(text);
	text = result[i][12];
    while(text.length()<12)
   {
      text+=" ";
   }
	out.print(text);
	count++;
	response.getWriter().write("\r\n"); 
}
*/
%>