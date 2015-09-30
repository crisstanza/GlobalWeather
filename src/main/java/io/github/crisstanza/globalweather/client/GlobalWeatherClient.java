package io.github.crisstanza.globalweather.client;

import io.github.crisstanza.globalweather.config.Config;
import io.github.crisstanza.jchron.JChron;
import io.github.crisstanza.utils.FileSystemUtil;
import io.github.crisstanza.utils.JaxbUtils;
import net.webservicex.GetWeather;
import net.webservicex.GlobalWeather;
import net.webservicex.GlobalWeatherSoap;

/**
 * @author crisstanza, 30-Sep-2015
 */
public final class GlobalWeatherClient {

	private final Config config = Config.getInstance();

	public final void start() {
		GlobalWeather service = new GlobalWeather(config.getUrlGlobalWeather());
		GlobalWeatherSoap operation = service.getGlobalWeatherSoap();
		GetWeather request = request();
		{
			JChron chronCitiesByCountry = new JChron();
			chronCitiesByCountry.start();
			String resultCitiesByCountry = operation.getCitiesByCountry(countryName());
			chronCitiesByCountry.stop();
			System.out.println(result(resultCitiesByCountry, chronCitiesByCountry.read()));
		}
		System.out.println();
		{
			JChron chronWeather = new JChron();
			chronWeather.start();
			String resultWeather = operation.getWeather(request.getCityName(), request.getCountryName());
			chronWeather.stop();
			System.out.println(result(resultWeather, chronWeather.read()));
		}
	}

	private String countryName() {
		return FileSystemUtil.read(getClass().getResourceAsStream("countryName"));
	}

	private GetWeather request() {
		return JaxbUtils.unmarshal(getClass().getResourceAsStream("GetWeather.java.xml"), GetWeather.class);
	}

	private final String result(String result, String elapsedTime) {
		return String.format("%s %s", result, elapsedTime);
	}

}
