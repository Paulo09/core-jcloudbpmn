<% import org.codehaus.groovy.grails.orm.hibernate.support.ClosureEventTriggeringInterceptor as Events %>
<%=packageName%>
<html>
    <head>
		<title>Dados ${className} - jMob!le Developer</title>
		<meta name="keywords" content="" />
		<meta name="description" content="" />
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<g:javascript library="validacao" />
		<link href="http://fonts.googleapis.com/css?family=Open+Sans:300,400,700" rel="stylesheet" type="text/css">
		<link rel="stylesheet" href="\${createLinkTo(dir:'css',file:'font-awesome.min.css')}" />		
		<link rel="stylesheet" href="\${createLinkTo(dir:'css',file:'bootstrap.min.css')}" />
	    <link rel="stylesheet" href="\${createLinkTo(dir:'css',file:'bootstrap-theme.min.css')}" />
		<link rel="stylesheet" href="\${createLinkTo(dir:'css',file:'bootstrap-social.css')}" />
		<link rel="stylesheet" href="\${createLinkTo(dir:'css',file:'templatemo_style.css')}" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link rel="stylesheet" href="\${createLinkTo(dir:'css',file:'font-awesome.min2.css')}" />
		<link rel="stylesheet" href="\${createLinkTo(dir:'css',file:'wb11_anothergrid.css')}" />		
		<g:javascript library="jquery" />
		<g:javascript library="interface" />
		<g:javascript library="menu" />
		<link rel="stylesheet" href="\${createLinkTo(dir:'css',file:'style.css')}" />	
    </head>
	
   <body class="templatemo-bg-image-1">
		<div class="container">
		<div class="col-md-12">			
			<form class="form-horizontal templatemo-login-form-2" role="form" method="post">
			
        <div class="nav">
            <span class="menuButton"><a class="home" href="\${createLinkTo(dir:'')}">Principal</a></span>
            <span class="menuButton"><g:link class="list" action="list">Listar ${className}</g:link></span>
            <span class="menuButton"><g:link class="create" action="create">Cadastrar ${className}</g:link></span>
        </div>
        <div class="body">
            <h3 align="center">Dados ${className}</h3>
            <g:if test="\${flash.message}">
				<div class="templatemo-bg-image-1" align="center">\${flash.message}</div>
            </g:if>
            <div class="dialog" align="center">
                <table>
                    <tbody>

                    <%
                        excludedProps = ['version',
                                           Events.ONLOAD_EVENT,
                                           Events.BEFORE_DELETE_EVENT,
                                           Events.BEFORE_INSERT_EVENT,
                                           Events.BEFORE_UPDATE_EVENT]
                        props = domainClass.properties.findAll { !excludedProps.contains(it.name) }
                        Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[]))
                        props.each { p -> %>
						<% def dataFormat="${p.type}";def cifra='R$'%>
						<%def apiQrcode="";p.name.eachMatch("qrcode"){condicao->apiQrcode=condicao}%>
						<%def apiMapa="";p.name.eachMatch("mapa"){condicao->apiMapa=condicao}%>
						<%def apiLink="";p.name.eachMatch("link"){condicao->apiLink=condicao}%>
						<%def apiVideo="";p.name.eachMatch("video"){condicao->apiVideo=condicao}%>
				        <tr class="prop">
                            <td valign="top1" class="name"><b>${p.naturalName}:</td>
                            <% if(p.isEnum()) { %>
                            <td valign="top" class="value">\${${propertyName}?.${p.name}?.encodeAsHTML()}</td>
                            <% } else if(p.oneToMany) { %>
                            <td  valign="top" style="text-align:left;" class="value">
                                <ul>
                                <g:each var="${p.name[0]}" in="\${${propertyName}.${p.name}}">
                                    <li><g:link controller="${p.referencedDomainClass?.propertyName}" action="show" id="\${${p.name[0]}.id}">\${${p.name[0]}?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                            <%  } else if(p.manyToOne || p.oneToOne) { %>
                            <td valign="top" class="value"><g:link controller="${p.referencedDomainClass?.propertyName}" action="show" id="\${${propertyName}?.${p.name}?.id}">\${${propertyName}?.${p.name}?.encodeAsHTML()}</g:link></td>
                            <%  } else if(dataFormat !="class java.util.Date" && dataFormat!="class java.lang.Boolean" && dataFormat!="class java.lang.Float" && !apiQrcode && !apiMapa && !apiLink && !apiVideo) { %>
                            <td valign="top" class="value">\${fieldValue(bean:${propertyName}, field:'${p.name}')}</td>
			                <%  } %>
							<%if(apiQrcode){%><td valign="top" class="value"><img src="http://chart.apis.google.com/chart?cht=qr&chl=\${fieldValue(bean:${propertyName}, field:'${p.name}')} &chs=180x180" alt="Qrcod"/></td><%}%>
							<%if(apiMapa){%><td valign="top" class="value">\${${propertyName}.${p.name}}</td><%}%>
							<%if(apiLink){%><td valign="top" class="value"><a href="\${${propertyName}.${p.name}}">\${${propertyName}.${p.name}}</td><%}%>
							<%if(apiVideo){%><td valign="top" class="value"><iframe width="399" height="217" src="\${${propertyName}.${p.name}}" frameborder="0"></iframe></td><%}%>
							<%if(dataFormat=="class java.util.Date"){%><td valign="top" class="value">\${String.format('%td/%<tm/%<tY',${domainClass.propertyName}?.${p.name})}</td><%}%>
							<%if(dataFormat=="class java.lang.Boolean"){%><td valign="top" class="value"><g:simNao  value="\${fieldValue(bean:${propertyName}, field:'${p.name}')}"/></td><%}%>
							<%if(dataFormat=="class java.lang.Float"){%><td valign="top" class="value">${cifra} <g: formatNumber number="\${${propertyName}.${p.name}}" format="###,###.###"/><%}%>
					    </tr>
                    <%  } %>
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <input type="hidden" name="id" value="\${${propertyName}?.id}" />
                    <b>&nbsp;<span class="button"><g:actionSubmit class="btn btn-facebook" onclick="return confirm('Deseja editar os dados?');" value="Editar" action="edit" /></span>
                    <b>&nbsp;<span class="button"><g:actionSubmit class="btn btn-facebook" onclick="return confirm('Deseja apagar os dados?');" value="Apagar" action='delete' /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
