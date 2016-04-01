# archiva-docker
Vanilla installation of Archiva 2.2 (see [official stand-alone installation instructions](https://archiva.apache.org/docs/2.2.0/adminguide/standalone.html)).

The environment variable `ARCHIVA_BASE` is set to `/var/archiva`. Config and data directories within are created if missing, or an existing `ARCHIVA_BASE` may be mounted in from the Docker host.

The environment variable `ARCHIVA_CONTEXT_PATH` is set to `/`.  If you would like to use this container behind a reverse proxy (e.g. `example.org/archiva`), you should set `ARCHIVA_CONTEXT_PATH` to `/archiva`.

Server listens on `8080`, map to whatever you want on the Docker host.

See DockerHub automated build of this Docker image at [ninjaben/archiva-docker](https://hub.docker.com/r/ninjaben/archiva-docker/).

Example usage:
```
sudo docker run -v ~/existing-archiva-base:/var/archiva -p 8080:8080 -d ninjaben/archiva-docker
```

# email and other server config
You may wish to set up email or do other server config.  These things don't live in this Docker image because they might use  your own infrastructure and credentials. But you can mount them in when launching a container (it's all under `/var/archiva`).

For example, this config makes an email resource available in the Jetty container (using [gmail's free smpt service](https://support.google.com/a/answer/176600?hl=en)).  Archiva knows how to find it from there:

`/var/archiva/conf/jetty.xml`
```
  <New id="validation_mail" class="org.eclipse.jetty.plus.jndi.Resource">
    <Arg>mail/Session</Arg>
    <Arg>
      <New class="org.eclipse.jetty.jndi.factories.MailSessionReference">
        <Set name="user">***</Set>
        <Set name="password">***</Set>
        <Set name="properties">
          <New class="java.util.Properties">
            <Put name="mail.user">***</Put>
            <Put name="mail.password">***</Put>
            <Put name="mail.smtp.host">smtp.gmail.com</Put>
            <Put name="mail.transport.protocol">smtp</Put>
            <Put name="mail.smtp.port">587</Put>
            <Put name="mail.smtp.auth">true</Put>
            <Put name="mail.smtp.starttls.enable">true</Put>
            <Put name="mail.debug">true</Put>
          </New>
        </Set>
      </New>
    </Arg>
  </New>
```
