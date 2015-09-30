package io.github.crisstanza.utils;

import java.io.StringReader;
import java.io.StringWriter;

import javax.xml.transform.OutputKeys;
import javax.xml.transform.Source;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;

/**
 * @author crisstanza, 14-Sep-2015
 */
public final class XmlUtils {

	private static final String YES = "yes";
	private static final String NO = "no";

	private static final String INDENT_AMOUNT = "{http://xml.apache.org/xslt}indent-amount";
	private static final String FOUR = "4";

	private static final String XML_DECLARATION_WITH_NO_NEW_LINE = "\\?><";
	private static final String XML_DECLARATION_WITH_NEW_LINE = "\\?>\n<";

	private XmlUtils() {
	}

	public static String format(String xml) {
		try {
			Source xmlInput = new StreamSource(new StringReader(xml));
			StreamResult xmlOutput = new StreamResult(new StringWriter());
			Transformer transformer = TransformerFactory.newInstance().newTransformer();
			transformer.setOutputProperty(OutputKeys.INDENT, YES);
			transformer.setOutputProperty(OutputKeys.OMIT_XML_DECLARATION, NO);
			transformer.setOutputProperty(INDENT_AMOUNT, FOUR);
			transformer.transform(xmlInput, xmlOutput);
			String newXml = xmlOutput.getWriter().toString();
			return newXml.replaceFirst(XML_DECLARATION_WITH_NO_NEW_LINE, XML_DECLARATION_WITH_NEW_LINE);
		} catch (final Exception exc) {
			throw ExceptionUtil.newRuntimeException(exc);
		}
	}
}
