<% import org.codehaus.groovy.grails.orm.hibernate.support.ClosureEventTriggeringInterceptor as Events %>
<%=packageName%>
<html>
    <head>
		<title>Editar ${className} - jMob!le Developer</title>
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
            <h3 align="center">Editar ${className}</h3>
            <g:if test="\${flash.message}">
            <div class="message" align="center">\${flash.message}</div>
            </g:if>
            <g:hasErrors bean="\${${propertyName}}">
            <div class="errors">
                <g:renderErrors bean="\${${propertyName}}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" <%= multiPart ? ' enctype="multipart/form-data"' : '' %>>
                <input type="hidden" name="id" value="\${${propertyName}?.id}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        <%
                            excludedProps = ['version',
                                             'id',
                                               Events.ONLOAD_EVENT,
                                               Events.BEFORE_DELETE_EVENT,
                                               Events.BEFORE_INSERT_EVENT,
                                               Events.BEFORE_UPDATE_EVENT]
                            props = domainClass.properties.findAll { !excludedProps.contains(it.name) }
                            
                            Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[]))
                            props.each { p ->
                                cp = domainClass.constrainedProperties[p.name]
                                display = (cp ? cp.display : true)        
                                if(display) { %>
                            <div class="form-group">
				                <div class="col-md-12">	
                                    <label class="control-label">${p.naturalName}</label>
                                <div class="templatemo-input-icon-container">
                                    ${renderEditor(p)}
							     </div>		            		            		            
				                </div>
						     </div>	 
                        <%  }   } %>
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <b>&nbsp;<g:actionSubmit class="btn btn-facebook" value="Salvar" action="Update" />
                    <b>&nbsp;<g:actionSubmit class="btn btn-facebook" onclick="return confirm('Deseja apagar os dados?');" value="Apagar" action="Delete" />
                </div>
            </g:form>
        </div>
    </body>
</html>
