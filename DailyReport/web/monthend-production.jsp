<%-- 
    Document   : monthend-production
    Created on : Jun 13, 2014, 9:12:12 AM
    Author     : rnaidoo
--%>

<%@page import="za.co.argility.furnmart.servlet.helper.MonthendData"%>
<%@page import="za.co.argility.furnmart.entity.MonthendEntity"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="za.co.argility.furnmart.entity.ReplicationEntity"%>
<%@page import="java.util.List"%>
<%@page import="za.co.argility.furnmart.servlet.helper.ReplicationData"%>
<%@page import="za.co.argility.furnmart.servlet.SessionAttribute"%>
<% 
    // get the data from the session
    
    MonthendData data = (MonthendData)session.getAttribute(SessionAttribute.MONTHEND_DATA_TAG);
    if (data == null) {
        response.sendRedirect(WebPages.BASE_APP_URL + "/MonthEndProduction?tab=production"); 
        return;
    }
    
    // replication details
    List<MonthendEntity> details = data.getMonthendDetails();
    System.out.println("details-- > " + details.size());
    if (details == null)
        details = new ArrayList<MonthendEntity>();
    
    // the branch list
    List<String> branches = data.getMonthendBranchList();
    if (branches == null)
        branches = new ArrayList<String>(); 
    
    // process types
    List<String> processes = data.getProcesses();
    if (processes == null)
        processes = new ArrayList<String>();
    
    SimpleDateFormat formatter = new SimpleDateFormat("dd MMMM yyyy HH:mm:ss");
    
%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        
        <title>Furnmart Monthend Production Stats Page</title>
          <%@include file="master/global-header.jspf" %>
          <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css" />
           <link type="text/css" rel="stylesheet" href="stylesheets/biExtracts.css" />
    </head>
    <body>
          <div class="header">
                <div class="wrapper" ><p>Furnmart Monthend Production Stats</p></div>
          </div>
          
           <div class="subContentArea">
            
               <div class="subHeader"><center>Monthend Extracts</center></div>   
               
              
        
          <table border="0" cellspacing="2" cellpadding="2" width="50%">
                    
                    <thead>
                         <tr class="headerRow"> 
                             <th style="text-align: center">Branch</th>
                              <th style="text-align: center">Branch Type</th>                              
                            <th>Debtors</th>     
                            <th>Creditors</th>
                            <th>Cash Book</th>
                            <th>New GL Tran</th>     
                          
                        </tr>
                    </thead>
                 
                    <tbody>
                        
                        
                        
                        <% 
                            int count = 0;    
                            for (MonthendEntity entity : details){ 
                                ++count;
                                boolean isEven = (count % 2 == 0);
                                String debtorsFlag = "images/ok.png";
                                if (entity.isIsDebtorsRun() == false)
                                    debtorsFlag = "images/error.png";
                                 String creditorsFlag = "images/ok.png";
                                if (entity.isIsCreditorsRun() == false)
                                    creditorsFlag = "images/error.png";
                                String cashBookFlag = "images/ok.png";
                                if (entity.isIsCashBookExtractRun()== false)
                                    cashBookFlag = "images/error.png";
                                String newGLTranFlag = "images/ok.png";
                                if (entity.isIsNewGLTranExtRun()== false)
                                    newGLTranFlag = "images/error.png";
                                     
                                       %>                          
                            
                            
                            <tr class="<%= isEven ? "dataRowEven" : "dataRowOdd" %>">
                                <td span class="bigText" style="text-align: center"><%= entity.getBranchCode()  %></td>
                                <td span class="smallText" style="text-align: center"><%= entity.getBranchType()  %></td>
                                <td style="text-align: center"><img src="<%= debtorsFlag %>" style="width:36px;" /></td>
                                <td style="text-align: center"><img src="<%= creditorsFlag %>" style="width:36px" /></td>
                                <td style="text-align: center"><img src="<%= cashBookFlag %>" style="width:36px" /></td>
                                <td style="text-align: center"><img src="<%= newGLTranFlag %>" style="width:36px" /></td>                                  
                            </tr>
                            
                                    
                           <% }
                               
                        %>
                    </tbody>
          </table>
        </div>
    </body>
</html>
                       