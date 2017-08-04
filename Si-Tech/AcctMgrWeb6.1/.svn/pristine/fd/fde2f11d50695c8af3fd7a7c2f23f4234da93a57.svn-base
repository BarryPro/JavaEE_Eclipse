package com.sitech.acctmgr.comp.webservice;

/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements. See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership. The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License. You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied. See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

import java.util.ArrayList;
import java.util.Iterator;

import javax.xml.namespace.QName;

import org.apache.axiom.om.OMAbstractFactory;
import org.apache.axiom.om.OMElement;
import org.apache.axiom.soap.SOAP12Constants;
import org.apache.axiom.soap.SOAPEnvelope;
import org.apache.axiom.soap.SOAPFactory;
import org.apache.axiom.soap.SOAPHeader;
import org.apache.axiom.soap.SOAPHeaderBlock;
import org.apache.axis2.AxisFault;
import org.apache.axis2.addressing.EndpointReference;
import org.apache.axis2.client.OperationClient;
import org.apache.axis2.client.Options;
import org.apache.axis2.context.ConfigurationContext;
import org.apache.axis2.context.MessageContext;
import org.apache.axis2.context.ServiceContext;
import org.apache.axis2.context.ServiceGroupContext;
import org.apache.axis2.description.AxisModule;
import org.apache.axis2.description.AxisOperation;
import org.apache.axis2.description.AxisService;
import org.apache.axis2.description.AxisServiceGroup;
import org.apache.axis2.description.OutInAxisOperation;
import org.apache.axis2.description.OutOnlyAxisOperation;
import org.apache.axis2.description.RobustOutOnlyAxisOperation;
import org.apache.axis2.engine.AxisConfiguration;
import org.apache.axis2.engine.ListenerManager;
import org.apache.axis2.i18n.Messages;
import org.apache.axis2.util.Counter;
import org.apache.axis2.wsdl.WSDLConstants;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class ESBServiceClientEx {
	protected static final Logger log = LoggerFactory.getLogger(ESBServiceClientEx.class);

	/**
	 * Base name used for a service created without an existing configuration.
	 */
	public static final String ANON_SERVICE = "anonService";

	/**
	 * Counter used to generate the anonymous service name.
	 */
	private static Counter anonServiceCounter = new Counter();

	/**
	 * Operation name used for an anonymous out-only operation (meaning we send
	 * a message with no response allowed from the service, equivalent to a WSDL
	 * In-Only operation).
	 */
	public static final QName ANON_OUT_ONLY_OP = new QName("anonOutonlyOp");

	/**
	 * Operation name used for an anonymous robust-out-only operation (meaning
	 * we send a message, with the only possible response a fault, equivalent to
	 * a WSDL Robust-In-Only operation).
	 */
	public static final QName ANON_ROBUST_OUT_ONLY_OP = new QName("anonRobustOp");

	/**
	 * Operation name used for an anonymous in-out operation (meaning we sent a
	 * message and receive a response, equivalent to a WSDL In-Out operation).
	 */
	public static final QName ANON_OUT_IN_OP = new QName("anonOutInOp");

	// the meta-data of the service that this client access
	private AxisService axisService;

	// the configuration in which my meta-data lives
	private AxisConfiguration axisConfig;

	// the configuration context in which I live
	private ConfigurationContext configContext;

	// service context for this specific service instance
	private ServiceContext serviceContext;

	// client options for this service interaction
	private Options options = new Options();

	// options that must override those of the child operation client also
	private Options overrideOptions;

	// list of headers to be sent with the simple APIs
	private ArrayList headers;

	// whether we create configctx or not
	private boolean createConfigCtx = false;

	private int hashCode;

	/**
	 * Create a service client configured to work with a specific AxisService.
	 * If this service is already in the world that's handed in (in the form of
	 * a ConfigurationContext) then I will happily work in it. If not I will
	 * create a small little virtual world and live there.
	 *
	 * @param configContext
	 *            The configuration context under which this service lives (may
	 *            be null, in which case a new local one will be created)
	 * @param axisService
	 *            The service for which this is the client (may be
	 *            <code>null</code>, in which case an anonymous service will be
	 *            created)
	 * @throws AxisFault
	 *             if something goes wrong while creating a config context (if
	 *             needed)
	 */
	public ESBServiceClientEx(ConfigurationContext configContext, AxisService axisService) throws AxisFault {
		configureServiceClient(configContext, axisService);
	}

	private void configureServiceClient(ConfigurationContext configContext, AxisService axisService) throws AxisFault {
		// if (configContext == null) {
		// if (ListenerManager.defaultConfigurationContext == null) {
		// configContext = ConfigurationContextFactory
		// .createConfigurationContextFromFileSystem(null, null);
		// createConfigCtx = true;
		// } else {
		// configContext = ListenerManager.defaultConfigurationContext;
		// }
		// }
		this.configContext = configContext;
		hashCode = (int) anonServiceCounter.incrementAndGet();

		// Initialize transports
		ListenerManager transportManager = configContext.getListenerManager();
		if (transportManager == null) {
			transportManager = new ListenerManager();
			transportManager.init(this.configContext);
		}

		// save the axisConfig and service
		axisConfig = configContext.getAxisConfiguration();
		if (axisService == null) {
			axisService = createAnonymousService();
		}
		this.axisService = axisService;
		if (axisConfig.getService(axisService.getName()) == null) {
			axisService.setClientSide(true);
			axisConfig.addService(axisService);
		} else {
			throw new AxisFault(Messages.getMessage("twoservicecannothavesamename", axisService.getName()));
		}

		AxisServiceGroup axisServiceGroup = axisService.getAxisServiceGroup();
		ServiceGroupContext sgc = configContext.createServiceGroupContext(axisServiceGroup);
		serviceContext = sgc.getServiceContext(axisService);
	}

	/**
	 * Create a service client by assuming an anonymous service and any other
	 * necessary information.
	 *
	 * @throws AxisFault
	 *             in case of error
	 */
	public ESBServiceClientEx() throws AxisFault {
		this(null, null);
	}

	/**
	 * Create an anonymous axisService with one (anonymous) operation for each
	 * MEP that we support dealing with anonymously using the convenience APIs.
	 *
	 * @return the minted anonymous service
	 */
	private AxisService createAnonymousService() {
		// now add anonymous operations to the axis2 service for use with the
		// shortcut client API. NOTE: We only add the ones we know we'll use
		// later in the convenience API; if you use
		// this constructor then you can't expect any magic!
		AxisService axisService = new AxisService(ANON_SERVICE + anonServiceCounter.incrementAndGet());
		RobustOutOnlyAxisOperation robustoutoonlyOperation = new RobustOutOnlyAxisOperation(ANON_ROBUST_OUT_ONLY_OP);
		axisService.addOperation(robustoutoonlyOperation);

		OutOnlyAxisOperation outOnlyOperation = new OutOnlyAxisOperation(ANON_OUT_ONLY_OP);
		axisService.addOperation(outOnlyOperation);

		OutInAxisOperation outInOperation = new OutInAxisOperation(ANON_OUT_IN_OP);
		axisService.addOperation(outInOperation);
		return axisService;
	}

	/**
	 * Returns the AxisConfiguration associated with the client.
	 */
	public AxisConfiguration getAxisConfiguration() {
		synchronized (this.axisConfig) {
			return axisConfig;
		}
	}

	/**
	 * Return the AxisService this is a client for. This is primarily useful
	 * when the AxisService is created anonymously or from WSDL as otherwise the
	 * user had the AxisService to start with.
	 *
	 * @return the axisService
	 */
	public AxisService getAxisService() {
		return axisService;
	}

	/**
	 * Set the basic client configuration related to this service interaction.
	 *
	 * @param options
	 *            (non-<code>null</code>)
	 */
	public void setOptions(Options options) {
		this.options = options;
	}

	/**
	 * Get the basic client configuration from this service interaction.
	 *
	 * @return options
	 */
	public Options getOptions() {
		return options;
	}

	/**
	 * Set a client configuration to override the normal options used by an
	 * operation client. Any values set in this configuration will be used for
	 * each client, with the standard values for the client still used for any
	 * values not set in the override configuration.
	 *
	 * @param overrideOptions
	 *            the Options to use
	 */
	public void setOverrideOptions(Options overrideOptions) {
		this.overrideOptions = overrideOptions;
	}

	/**
	 * Get the client configuration used to override the normal options set by
	 * an operation client.
	 *
	 * @return override options
	 */
	public Options getOverrideOptions() {
		return overrideOptions;
	}

	/**
	 * Engage a module for this service client.
	 *
	 * @param moduleName
	 *            name of the module to engage
	 * @throws AxisFault
	 *             if something goes wrong
	 */
	public void engageModule(String moduleName) throws AxisFault {
		synchronized (this.axisConfig) {
			AxisModule module = axisConfig.getModule(moduleName);
			if (module != null) {
				axisService.engageModule(module);
			} else {
				throw new AxisFault("Unable to engage module : " + moduleName);
			}
		}
	}

	/**
	 * Disengage a module for this service client
	 *
	 * @param moduleName
	 *            name of Module to disengage
	 */
	public void disengageModule(String moduleName) {
		synchronized (this.axisConfig) {
			AxisModule module = axisConfig.getModule(moduleName);
			if (module != null) {
				try {
					axisService.disengageModule(module);
				} catch (AxisFault axisFault) {
					log.error(axisFault.getMessage(), axisFault);
				}
			}
		}
	}

	/**
	 * Add an arbitrary XML element as a header to be sent with outgoing
	 * messages.
	 *
	 * @param header
	 *            header to be sent (non-<code>null</code>)
	 */
	public void addHeader(OMElement header) {
		if (headers == null) {
			headers = new ArrayList();
		}
		headers.add(header);
	}

	/**
	 * Add SOAP Header to be sent with outgoing messages.
	 *
	 * @param header
	 *            header to be sent (non-<code>null</code>)
	 */
	public void addHeader(SOAPHeaderBlock header) {
		if (headers == null) {
			headers = new ArrayList();
		}
		headers.add(header);
	}

	/**
	 * Remove all headers for outgoing message.
	 */
	public void removeHeaders() {
		if (headers != null) {
			headers.clear();
		}
	}

	/**
	 * Add a simple header containing some text to be sent with interactions.
	 *
	 * @param headerName
	 *            name of header to add
	 * @param headerText
	 *            text content for header
	 * @throws AxisFault
	 *             in case of error
	 */
	public void addStringHeader(QName headerName, String headerText) throws AxisFault {
		if (headerName.getNamespaceURI() == null || "".equals(headerName.getNamespaceURI())) {
			throw new AxisFault("Failed to add string header, you have to have namespaceURI for the QName");
		}
		OMElement omElement = OMAbstractFactory.getOMFactory().createOMElement(headerName, null);
		omElement.setText(headerText);
		addHeader(omElement);
	}

	// chentb.
	// add the option properties to the service context
	public void setServiceContextOptions(Options options) {
		String key;
		for (Iterator iter = options.getProperties().keySet().iterator(); iter.hasNext();) {
			key = (String) iter.next();
			serviceContext.setProperty(key, options.getProperties().get(key));
		}
	}

	// chentb.
	public OMElement sendReceiveEx(OMElement xmlPayload, OMElement header) throws AxisFault {
		MessageContext messageContext = new MessageContext();
		OperationClient operationClient = null;
		try {
			fillSOAPEnvelope(messageContext, xmlPayload, header, "1");
			AxisOperation axisOperation = axisService.getOperation(ANON_OUT_IN_OP);
			operationClient = axisOperation.createClient(serviceContext, options);
			operationClient.addMessageContext(messageContext);
			operationClient.execute(true);

			MessageContext response = operationClient.getMessageContext(WSDLConstants.MESSAGE_LABEL_IN_VALUE);
			response.getEnvelope().build();
			return response.getEnvelope().getBody().getFirstElement();
		} finally {
			if (operationClient != null) {
				operationClient.getOperationContext().cleanup();
				operationClient.complete(messageContext);
			}
			messageContext = null;
			operationClient = null;
		}
	}

	// chentb.
	public String sendReceiveStr(OMElement xmlPayload, OMElement header, String flag) throws AxisFault {
		MessageContext messageContext = new MessageContext();
		OperationClient operationClient = null;
		try {
			fillSOAPEnvelope(messageContext, xmlPayload, header, flag);
			AxisOperation axisOperation = axisService.getOperation(ANON_OUT_IN_OP);
			operationClient = axisOperation.createClient(serviceContext, options);
			operationClient.addMessageContext(messageContext);
			operationClient.execute(true);

			MessageContext response = operationClient.getMessageContext(WSDLConstants.MESSAGE_LABEL_IN_VALUE);
			OMElement result = response.getEnvelope().getBody().getFirstElement().getFirstElement();
			return result != null ? result.getText() : null;
		} finally {
			if (operationClient != null) {
				operationClient.getOperationContext().cleanup();
				operationClient.complete(messageContext);
			}
			messageContext = null;
			operationClient = null;
		}
	}

	/**
	 * Return the SOAP factory to use depending on what options have been set.
	 * If the SOAP version can not be seen in the options, version 1.1 is the
	 * default.
	 *
	 * @return the SOAP factory
	 * @see Options#setSoapVersionURI(String)
	 */
	private SOAPFactory getSOAPFactory() {
		String soapVersionURI = options.getSoapVersionURI();
		if (SOAP12Constants.SOAP_ENVELOPE_NAMESPACE_URI.equals(soapVersionURI)) {
			return OMAbstractFactory.getSOAP12Factory();
		} else {
			// make the SOAP 1.1 the default SOAP version
			return OMAbstractFactory.getSOAP11Factory();
		}
	}

	// chentb.
	private void fillSOAPEnvelope(MessageContext messageContext, OMElement xmlPayload, OMElement header, String flag) throws AxisFault {
		messageContext.setServiceContext(serviceContext);
		SOAPFactory soapFactory = getSOAPFactory();
		SOAPEnvelope envelope = soapFactory.getDefaultEnvelope();
		if (xmlPayload != null) {
			envelope.getBody().addChild(xmlPayload);
		}
		addHeadersToEnvelope(envelope);
		messageContext.setEnvelope(envelope);

		if (!flag.equals("1")) {
			envelope.getHeader().addChild(header);// chentb
		}
	}

	/**
	 * Add all configured headers to a SOAP envelope.
	 *
	 * @param envelope
	 *            the SOAPEnvelope in which to write the headers
	 */
	public void addHeadersToEnvelope(SOAPEnvelope envelope) {
		if (headers != null) {
			SOAPHeader soapHeader = envelope.getHeader();
			for (int i = 0; i < headers.size(); i++) {
				soapHeader.addChild((OMElement) headers.get(i));
			}
		}
	}

	/**
	 * Get the endpoint reference for this client using a particular transport.
	 *
	 * @param transport
	 *            transport name (non-<code>null</code>)
	 * @return local endpoint
	 * @throws AxisFault
	 *             in case of error
	 */
	public EndpointReference getMyEPR(String transport) throws AxisFault {
		return serviceContext.getMyEPR(transport);
	}

	/**
	 * Get the endpoint reference for the service.
	 *
	 * @return service endpoint
	 */
	public EndpointReference getTargetEPR() {
		return serviceContext.getTargetEPR();
	}

	/**
	 * Set the endpoint reference for the service.
	 *
	 * @param targetEpr
	 *            the EPR this ServiceClientEx should target
	 */
	public void setTargetEPR(EndpointReference targetEpr) {
		serviceContext.setTargetEPR(targetEpr);
		options.setTo(targetEpr);
	}

	/**
	 * Get the service context.
	 *
	 * @return context
	 */
	public ServiceContext getServiceContext() {
		return serviceContext;
	}

	protected void finalize() throws Throwable {
		super.finalize();
		cleanup();
	}

	/**
	 * Clean up configuration created with this client. Call this method when
	 * you're done using the client, in order to discard any associated
	 * resources.
	 *
	 * @throws AxisFault
	 *             in case of error
	 */
	public void cleanup() throws AxisFault {
		// if a configuration context was created for this client there'll also
		// be a service group, so discard that
		if (!createConfigCtx) {
			String serviceGroupName = axisService.getAxisServiceGroup().getServiceGroupName();
			AxisConfiguration axisConfiguration = configContext.getAxisConfiguration();
			configContext.removeServiceGroupContext(axisService.getAxisServiceGroup()); // chentb.

			AxisServiceGroup asg = axisConfiguration.getServiceGroup(serviceGroupName);
			if (asg != null) {
				axisConfiguration.removeService(axisService.getName());// chentb.
				axisConfiguration.removeServiceGroup(serviceGroupName);
			}
		} else {
			configContext.terminate();
		}
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	public int hashCode() {
		return this.hashCode;
	}

	/**
	 * @see java.lang.Object#equals(java.lang.Object)
	 */
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (!(obj instanceof ESBServiceClientEx))
			return false;
		final ESBServiceClientEx other = (ESBServiceClientEx) obj;
		if (hashCode != other.hashCode)
			return false;
		return true;
	}

}
