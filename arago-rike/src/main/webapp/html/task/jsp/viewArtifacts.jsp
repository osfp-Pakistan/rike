<%@page import="de.arago.rike.data.Artifact"%>
<%@page import="de.arago.rike.data.Milestone"%>
<%@page import="de.arago.rike.util.TaskHelper"%>
<%@page import="de.arago.portlet.jsp.UserService"%>
<%@page import="de.arago.portlet.jsp.JspUserService"%>
<%@page import="de.arago.rike.util.ViewHelper"%>
<%@page import="com.liferay.portal.model.User"%>
<%@page import="de.arago.portlet.util.SecurityHelper"%>
<%@page import="de.arago.rike.data.Task.Status"%>
<%@page import="com.liferay.portal.service.UserLocalServiceUtil"%>
<%@page import="de.arago.rike.data.Task"%>
<%@page import="javax.portlet.WindowState"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="org.apache.commons.lang.StringEscapeUtils"%>
<%@page import="java.util.List"%>
<%@ page import="java.util.Date" %>
<%@ taglib uri="http://java.sun.com/portlet" prefix="portlet" %>
<%@ page contentType="text/html; charset=UTF-8" %> 

<portlet:defineObjects />

<%
  try {
    UserService service = new JspUserService(renderRequest, portletSession);
    String user = (String) portletSession.getAttribute("userEmail");
    List<Artifact> artifacts = (List) portletSession.getAttribute("artifacts");
%>

<div class="portlet big <%= renderRequest.getWindowState().equals(WindowState.MAXIMIZED) ? "maximized" : ""%>" style="" id="<portlet:namespace />Portlet">
  <div class="portletbox">
    <!-- head -->
    <div class="head">
      <h1>
        Artifacts
        <span class="right">
          <a href="javascript:void(0);" onclick="return de.arago.help.Provider.show('rike.task');" title="Help"><span class="icon">S</span></a> 
          <% if (renderRequest.getWindowState().equals(WindowState.MAXIMIZED)) {%>
          <a href="<portlet:actionURL portletMode="view" windowState="normal"/>" title="Minimize"><span class="icon">%</span></a>
          <% } else {%>
          <a href="<portlet:actionURL portletMode="view" windowState="maximized"/>" title="Maximize"><span class="icon">%</span></a>
          <% }%>
        </span>
      </h1>
      <div class="inner">
        <div class="left">
          <ul class="tabbar">
            <li><a href="<portlet:actionURL portletMode="view"/>&action=showTask">Task</a></li>
            <li ><a href="<portlet:actionURL portletMode="view"/>&action=showMilestones">Milestones</a></li>
            <li class="selected"><a href="#">Artifacts</a></li>
          </ul>
        </div>
        <div class="right">
          <a href="<portlet:actionURL portletMode="view" />&action=editArtifact">New</a>
        </div>

      </div>
    </div>
    <div class="content nofooter">

      <table>
        <thead></thead>
        <tbody>
          <% for (Artifact a : artifacts) {%>


          <tr>
            <td><%=a.getId()%></td>
            <td><a href="<portlet:actionURL portletMode="view" />&action=showArtifact&id=<%= a.getId()%>"><%=StringEscapeUtils.escapeHtml(a.getName())%></a></td>
            <td><%= ViewHelper.formatURL(a.getUrl())%></td>
          </tr>

          <% }%>


        </tbody>
      </table>

    </div>
  </div>
</div>
<% } catch (Throwable t) {

    out.write("Please Reload");
    t.printStackTrace(System.err);
    throw (t);
  }%>