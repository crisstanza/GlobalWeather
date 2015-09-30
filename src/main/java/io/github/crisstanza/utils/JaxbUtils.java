package io.github.crisstanza.utils;

import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.StringReader;
import java.io.StringWriter;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.Marshaller;
import javax.xml.bind.Unmarshaller;

/**
 * @author crisstanza, 30-Sep-2015
 */
public final class JaxbUtils {

	public static final boolean SILENT = true;

	private JaxbUtils() {
	}

	public static String marshal(Object obj) {
		try {
			JAXBContext jaxb = JAXBContext.newInstance(obj.getClass());
			Marshaller marshaller = jaxb.createMarshaller();
			marshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
			StringWriter result = new StringWriter();
			marshaller.marshal(obj, result);
			return result.toString().trim();
		} catch (final Exception exc) {
			throw ExceptionUtil.newRuntimeException(exc);
		}
	}

	@SuppressWarnings("unchecked")
	public static <T> T unmarshal(String xml, Class<T> clazz) {
		try {
			JAXBContext jaxb = JAXBContext.newInstance(clazz);
			Unmarshaller unmarshaller = jaxb.createUnmarshaller();
			return (T) unmarshaller.unmarshal(new StringReader(xml));
		} catch (final Exception exc) {
			throw ExceptionUtil.newRuntimeException(exc);
		}
	}

	@SuppressWarnings("unchecked")
	public static <T> T unmarshal(InputStream xml, Class<T> clazz) {
		try {
			JAXBContext jaxb = JAXBContext.newInstance(clazz);
			Unmarshaller unmarshaller = jaxb.createUnmarshaller();
			return (T) unmarshaller.unmarshal(new InputStreamReader(xml));
		} catch (final Exception exc) {
			throw ExceptionUtil.newRuntimeException(exc);
		}
	}

	public static <T> T unmarshal(String xml, Class<T> clazz, boolean silent) {
		try {
			return JaxbUtils.unmarshal(xml, clazz);
		} catch (RuntimeException exc) {
			if (silent) {
				return null;
			} else {
				throw ExceptionUtil.newRuntimeException(exc);
			}
		}
	}

}
