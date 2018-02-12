<% import org.codehaus.groovy.grails.orm.hibernate.support.ClosureEventTriggeringInterceptor as Events %>
<%=packageName%>
<html>
    <head>
        <title>Listar ${className} - jMob!le Developer</title>
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
            <span class="menuButton"><g:link class="create" action="create">Cadastrar ${className}</g:link></span>
        </div>
        <div class="body">
            <h3 align="center">Listar ${className}</h3>
            <g:if test="\${flash.message}">
            <div class="message">\${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        <%
                            excludedProps = ['version',
                                               Events.ONLOAD_EVENT,
                                               Events.BEFORE_DELETE_EVENT,
                                               Events.BEFORE_INSERT_EVENT,
                                               Events.BEFORE_UPDATE_EVENT]
                            
                            props = domainClass.properties.findAll { !excludedProps.contains(it.name) && it.type != Set.class }
                            Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[]))
                            props.eachWithIndex { p,i ->
                   	            if(i < 6) {
                   	                if(p.isAssociation()) { %>
                   	        <th>${p.naturalName}</th>
                   	    <%          } else { %>
                   	        <g:sortableColumn property="${p.name}" title="${p.naturalName}" />
                        <%  }   }   } %>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="\${${propertyName}List}" status="i" var="${propertyName}">
                        <tr class="\${(i % 2) == 0 ? 'templatemo-bg-image-1' : 'even'}">
                        <%  props.eachWithIndex { p,i ->
                                if(i == 0) { %>
                            <td><g:link action="show" id="\${${propertyName}.id}">\${fieldValue(bean:${propertyName}, field:'${p.name}')}</g:link></td>
                        <%      } else if(i < 6) { %>
                            <td>\${fieldValue(bean:${propertyName}, field:'${p.name}')}</td>
                        <%  }   } %>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="\${${className}.count()}" />
            </div>
        </div>
    </body>
</html>
