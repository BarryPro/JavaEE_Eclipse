// Decompiled by DJ v2.9.9.60 Copyright 2000 Atanas Neshkov  Date: 2009-10-29 19:04:20
// Home Page : http://members.fortunecity.com/neshkov/dj.html  - Check often for new version!
// Decompiler options: packimports(3) 
// Source File Name:   BusiAppException.java
package com.sitech.acctmgr.comp.webservice;

import java.io.PrintStream;
import java.io.PrintWriter;

public class ESBBusiAppException extends Exception
{

    public String getRetCode()
    {
        return retCode;
    }

    public String getRetMsg()
    {
        return retMsg;
    }

    public ESBBusiAppException(String msg)
    {
        super(msg);
    }

    public ESBBusiAppException(String retCode, String retMsg)
    {
        super(retMsg);
        this.retCode = retCode;
        this.retMsg = retMsg;
    }

    public ESBBusiAppException(String msg, Throwable ex)
    {
        super(msg);
        cause = ex;
    }

    public ESBBusiAppException(String retCode, String retMsg, Throwable ex)
    {
        super(retMsg);
        this.retCode = retCode;
        this.retMsg = retMsg;
        cause = ex;
    }

    public boolean contains(Class exClass)
    {
        if(exClass == null)
            return false;
        for(Throwable ex = this; ex != null;)
        {
            if(exClass.isInstance(ex))
                return true;
            if(ex instanceof Exception)
                ex = ((Exception)ex).getCause();
            else
                ex = null;
        }

        return false;
    }

    public Throwable getCause()
    {
        return cause == this ? null : cause;
    }

    public String getMessage()
    {
        String message = super.getMessage();
        Throwable cause = getCause();
        if(cause != null)
            return message + "; nested exception is " + cause;
        else
            return message;
    }

    public void printStackTrace(PrintWriter pw)
    {
        if(getCause() == null)
        {
            super.printStackTrace(pw);
        } else
        {
            pw.println(this);
            getCause().printStackTrace(pw);
        }
    }

    public void printStackTrace(PrintStream ps)
    {
        if(getCause() == null)
        {
            super.printStackTrace(ps);
        } else
        {
            ps.println(this);
            getCause().printStackTrace(ps);
        }
    }

    private Throwable cause;
    private String retCode;
    private String retMsg;
}