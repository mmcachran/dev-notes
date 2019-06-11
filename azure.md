## Force redirect all the things to https with web.config

```<?xml version="1.0" encoding="UTF-8"?>
  <configuration>
    <system.webServer>
      <rewrite>
        <rules>
          <clear />
          <rule name="Redirect to https" stopProcessing="true">
            <match url="(.*)" />
              <conditions>
                <add input="{HTTPS}" pattern="off" ignoreCase="true" />
              </conditions>
              <action type="Redirect" url="https://{HTTP_HOST}{REQUEST_URI}" redirectType="Permanent" appendQueryString="false" />
          </rule>
         </rules>
    </rewrite>
  </system.webServer>
</configuration>```


## See Block frames with web.config
### Required on MS sites per internal security review.

```<system.webServer>
  ...
 
  <httpProtocol>
    <customHeaders>
      <add name="X-Frame-Options" value="SAMEORIGIN" />
    </customHeaders>
  </httpProtocol>
 
  ...
</system.webServer>```
