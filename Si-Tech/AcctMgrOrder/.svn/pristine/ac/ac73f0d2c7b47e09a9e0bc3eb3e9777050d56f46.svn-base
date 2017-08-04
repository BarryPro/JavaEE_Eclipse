package com.sitech.acctmgr.app.test;

/*************************** ********************************/
import java.sql.DriverManager;

public class Demo_JDBC
{
    public static void main(String[] args)throws Exception
    {
        int jniFlag = 0;
        int row = 10;       
           
        if(args.length >= 1)
            row = Integer.parseInt(args[0]);
            
        if(args.length >= 2)
            jniFlag = Integer.parseInt(args[1]);
            
        System.out.println("row="+row);
        Demo_JDBC ddd=new Demo_JDBC();
        ddd.testJDBC(row, jniFlag);
    }
    
    //JDBC
    public void testJDBC(int row, int jniFlag)
    {
        int i, nCount=0;
        String sql, str, connstr;
        java.sql.PreparedStatement pstmt;
        java.sql.Statement pstmt1;
        java.sql.ResultSet rs;
        java.sql.ResultSetMetaData rsmd;
        
        try
        {
            Class.forName("com.sitech.dmdb.Driver").newInstance();
            if(jniFlag == 0)
                connstr="jdbc:e-mobile://10.162.202.115:11503/wrtmdb_1";
            else
                connstr="jdbc:e-mobile://10.162.202.115:11503:1/wrtmdb_1";
            java.sql.Connection conn= DriverManager
            		.getConnection(connstr, "app","si-tech");

            conn.setAutoCommit(false);  
            pstmt1=conn.createStatement();

/*******************  Statement **************/
            System.out.println("*******************  Statement ************************");
//            nCount = pstmt1.executeUpdate("truncate table bbb");
//            nCount = pstmt1.executeUpdate("insert into bbb select distinct table_name||'��', 23, sysdate from dba_tables where length(table_name)<10");
//            System.out.println("###########  = " + nCount);
//            nCount=pstmt1.executeUpdate("update bbb set f2=f2+1");
//            System.out.println("########### �޸ļ�¼��= " + nCount);
//            
//            
//            /*��̬SQL�����޸�*/
//            pstmt1.clearBatch();
//            pstmt1.addBatch("update bbb set f2=f2+1");
//            pstmt1.addBatch("update bbb set f2=f2+3 where f1='BBB'");
//            int si[] = pstmt1.executeBatch();
//            System.out.println("########### = " + si[0] +"   " + si[1]+"  " + si.length);
            
            pstmt1.setMaxRows(3); 
            java.sql.ResultSet rs1 = pstmt1.executeQuery("select contract_no from BAL_ACCTBOOK_0 limit 10;");
            rsmd = rs1.getMetaData();
            nCount = rsmd.getColumnCount();  
            for(i=1; i<=nCount; i++)
                System.out.print(rsmd.getColumnName(i)+"\t");
            System.out.println("");
            
            i = 0;
            while(rs1.next())
            {
                str = "";
                for(int j=1; j<=nCount; j++)
                    str = str + rs1.getString(j) + "  ";
                i++;
                System.out.println(str);
            }
            System.out.println("########### = "+i+"\n\n\n");

/*************  CLOB ���� ***********************************************/
//            pstmt1.executeUpdate("truncate table t_lob");
//            pstmt=conn.prepareStatement("insert into t_lob values(?,?,?,?)");
//            for(i=0; i<4; i++)
//            {
//            	pstmt.setLong(1, 100+i);
//                pstmt.setString(2, i+"aaaaaaaaaaa CLOB_bbbbbbbbbbbbbb"+i);
//                pstmt.setString(3, "asd@"+i);
//                pstmt.setString(4, i+"ccc_CLOB_eeeeeeeeeeeeeee"+i);
//                pstmt.executeUpdate();            
//            }
//            conn.commit();
//            
//            pstmt.close();
//            pstmt=conn.prepareStatement("update t_lob set bb=?,dd=? where aa=?");
//            pstmt.setString(1, "9bbbbbbbbbbb_ CLOB_aaaaaaaa9");
//            pstmt.setString(2, "9eeeeeeeeeeee_ CLOB_cc9");
//            pstmt.setLong(3, 102);
//            pstmt.executeUpdate(); 
//            conn.commit();
//            
//            rs = pstmt1.executeQuery("select * from t_lob");
//            rsmd = rs.getMetaData();
//            nCount = rsmd.getColumnCount();
//            for(i=1; i<=nCount; i++)
//                System.out.print(rsmd.getColumnName(i)+"(" + rsmd.getColumnTypeName(i)+")    ");
//            System.out.println("");
//            
//            while(rs.next())
//            {
//                str = "";
//                for(int j=1; j<=nCount; j++)
//                    str = str + "^" + rs.getString(j) + "^    ";
//                System.out.println(str);
//            }
            
/*************  PreparedStatement ���� ***********************************************/
//            System.out.println("************  PreparedStatement ���� ******************************");
//            
//            //������
//            nCount = pstmt1.executeUpdate("truncate table mytest");
//            
//            //�������
//            sql="insert into mytest values(?,'aa','bb','cc','dd','e','f',?,?,'20240101000000','ff','gg')";
//            pstmt=conn.prepareStatement(sql);
//            pstmt.setLong(2, 1);
//            pstmt.setString(3, "20070101000001");
//            long time = System.currentTimeMillis();
//            for(i=0; i<row; i++)
//            {
//                pstmt.setString(1, "����"+i);
//                nCount=pstmt.executeUpdate();
//                conn.commit();
//            }
//            pstmt.close();
//            time = System.currentTimeMillis()-time; 
//            System.out.println("����"+row+"����¼ time = "+ time+"����  **************");          
            
//            //��ѯ����
//            sql = "select * from mytest where Msisdn=?";
//            pstmt=conn.prepareStatement(sql);    
//            rsmd = pstmt.getMetaData();
//            nCount = rsmd.getColumnCount();  //��ȡselect�ֶθ���    
//            for(i=1; i<=nCount; i++)
//            {
//               System.out.println(rsmd.getColumnName(i) + " " + rsmd.getColumnType(i));                   
//            }
//            System.out.println("");    
//                   
//            time = System.currentTimeMillis();
//            for(i=0; i<row; i++)
//            {
//                pstmt.setString(1, "����"+i);
//                rs=pstmt.executeQuery();                    
//                           
//                while(rs.next())
//                {
//                    str = "";
//                    for(int j=1; j<=nCount; j++)
//                        str = str + rs.getString(j) + "  ";
//                    if(row<=10)
//                        System.out.println(str);
//                }
//            }
//            pstmt.close();
//            time = System.currentTimeMillis()-time; 
//            System.out.println("��ѯ"+row+"����¼ time = "+ time+"����  **************\n\n");           
//
//
//            System.out.println("************  PreparedStatement Batch ���� ******************************");
//            sql="insert into mytest values(?,'aa','bb','cc','dd','e','f',?,?,'20240101000000','ff','gg')";
//            pstmt=conn.prepareStatement(sql);
//            pstmt.clearBatch();
//            time = System.currentTimeMillis();
//            int k = 0;
//            for(i=0; i<row; i++)
//            {
//            	pstmt.setString(1, "�й�"+i);
//            	pstmt.setLong(2, i);
//            	pstmt.setString(3, "20070101000001");            	
//                pstmt.addBatch();
//                k++;
//                
//                if( (k>=1000) || (i == row -1) )
//                {
//                	int[] result=pstmt.executeBatch();
//                	if(k<=10)
//                	{
//                	    for(int n=0; n<k; n++)
//                		    System.out.println("@@@@  " + result[n]);
//                    }
//                	conn.commit();
//                	pstmt.clearBatch();
//                	k = 0;
//                }
//            }
//            time = System.currentTimeMillis()-time; 
//            System.out.println("��������"+row+"����¼ time = "+ time+"����  **************\n\n");           
//            pstmt.close();
                        
            /*�˳�*/
            conn.close();
            conn=null;
            
        }
        catch(Exception ex)
        {
            System.out.println("Error: "+ex.getMessage());
        }
    }
}

