<%
response.setContentType("text/plain;charset=GBK");
response.setHeader("Content-disposition","attachment; filename=table.txt");

String result[][] = (String[][])request.getAttribute("result");


/*					   	
out.print("序号\t");
out.print("开票时间\t");
out.print("发票代码\t");
out.print("发票号码\t");
out.print("项目内容\t");
out.print("付款单位\t");
out.print("合计金额\t");
out.print("开票人\t");
out.print("备注\t");
out.print("收款单位名称\t");
out.print("收款单位纳税人识别号\t");
out.print("发票名称\t");
out.print("发票种类\t");
out.print("联次/组数");
response.getWriter().write("\r\n"); 
*/
for(int i=0;i<result.length;i++)
{
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
	out.print("\t");
	out.print(result[i][13]);
	out.print("\t");
	out.print(result[i][14]);
	out.print("\t");
	out.print(result[i][15]);
	if(i<result.length-1)
	{
		response.getWriter().write("\r\n"); 
	}	
}
/*
String text = "";
int count=1;
for(int i=0;i<result.length;i++)
{ 	
	text = result[i][2];
    while(text.length()<12)
   {
      text+="	";
   }
	out.print(text);
	text = result[i][3];
    while(text.length()<20)
   {
      text+=" ";
   }
	out.print(text);
	text = result[i][4];
    while(text.length()<16)
   {
      text+=" ";
   }
	out.print(text);
	text = result[i][5];
    while(text.length()<16)
   {
      text+=" ";
   }
	out.print(text);
	text = result[i][6];
    while(text.length()<20)
   {
      text+=" ";
   }
	out.print(text);
	text = result[i][7];
    while(text.length()<16)
   {
      text+=" ";
   }
	out.print(text);
	text = result[i][8];
    while(text.length()<16)
   {
      text+=" ";
   }
	out.print(text);
	text = result[i][9];
    while(text.length()<16)
   {
      text+=" ";
   }
	out.print(text);
	text = result[i][10];
    while(text.length()<16)
   {
      text+=" ";
   }
	out.print(text);
	text = result[i][11];
    while(text.length()<30)
   {
      text+=" ";
   }
	out.print(text);
	
	text = result[i][12];
    while(text.length()<22)
   {
      text+=" ";
   }
	out.print(text);
	text = result[i][13];
    while(text.length()<16)
   {
      text+=" ";
   }
	out.print(text);
	text = result[i][14];
    while(text.length()<16)
   {
      text+=" ";
   }
	out.print(text);
	text = result[i][15];
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