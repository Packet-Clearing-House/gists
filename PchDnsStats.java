/*
 * Packet Clearing House
 * Copyright 2018
 * MIT License
 * https://github.com/Packet-Clearing-House/gists
 *
 * An executable java class that demonstrates downloading dns stats from pch.net.
 * This is a skeleton; you must implement the code to process and save the stats.
 *
 * Dependencies:
 * compile group: 'org.apache.httpcomponents', name: 'fluent-hc', version: '4.5.6'
 * compile group: 'org.apache.commons', name: 'commons-csv', version: '1.6'  (optional)
 */

import org.apache.commons.csv.CSVFormat;
import org.apache.commons.csv.CSVParser;
import org.apache.commons.csv.CSVRecord;
import org.apache.http.client.fluent.Form;
import org.apache.http.client.fluent.Request;

import java.io.IOException;
import java.io.StringReader;
import java.util.Arrays;
import java.util.List;

class PchDnsStats {

    public static void main(String[] args) throws IOException {

        final String username = "username";
        final String password = "changeme";

        // the download format; choose one
        final String format = "dns_stats_table_time";   // stats by time interval
        //final String format = "dns_stats_table_city"; // stats by city

        // the zones to download
        final List<String> zones = Arrays.asList(
                "example"
        );

        // the days to download
        final List<String> dates = Arrays.asList(
                "20181101"
        );

        // and arbitrary nonce value; you do not need to change this value
        final String nonce = "100";

        // get the session cookie
        // note that httpcomponents stores the returned PCHSession-www cookie for subsequent queries
        Request.Post("https://www.pch.net/user/login")
                .addHeader("Cookie", "pch_nonce" + nonce + "=" + nonce)
                .bodyForm(
                        Form.form()
                                .add("login", username)
                                .add("password", password)
                                .add("pch_nonce", nonce)
                                .add("form_login", "form_login")
                                .build())
                .execute();

        // get reports for specified zones and dates
        for (String zone : zones) {
            for (String date : dates) {

                // uses PCHSession-www cookie returned above
                // alternatively use .saveContent(File) instead of .returnContent()
                String content = Request.Get("https://www.pch.net/api/anycast/" + format + "/" + zone + "/" + date).execute().returnContent().asString();

                // the content is comma-separated values
                CSVParser records = CSVFormat.RFC4180.withFirstRecordAsHeader().parse(new StringReader(content));
                for (CSVRecord record : records) {
                    // do something
                }
            }
        }

    }
}