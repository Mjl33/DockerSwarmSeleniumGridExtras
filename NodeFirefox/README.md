# Selenium Grid Node - Firefox (Extras)

Selenium Node configured to run Firefox

This is an extension of (https://github.com/SeleniumHQ/docker-selenium) and (https://github.com/groupon/Selenium-Grid-Extras).

## Dockerfile

[`mjlee1/node-firefox` Dockerfile](https://github.com/Mjl33/DockerSeleniumGrid/blob/master/NodeFirefox/Dockerfile)

## How to use this image

First, you will need a Selenium Grid Hub that the Node will connect to.

```
$ docker run -d -p 4444:4444 --name selenium-hub selenium/hub
```

Once the hub is up and running will want to launch nodes that can run tests. You can run as many nodes as you wish.

```
$ docker run -d --link selenium-hub:hub -v /dev/shm:/dev/shm selenium/node-firefox
```

## What is Selenium?
_Selenium automates browsers._ That's it! What you do with that power is entirely up to you. Primarily, it is for automating web applications for testing purposes, but is certainly not limited to just that. Boring web-based administration tasks can (and should!) also be automated as well.

Selenium has the support of some of the largest browser vendors who have taken (or are taking) steps to make Selenium a native part of their browser. It is also the core technology in countless other browser automation tools, APIs and frameworks.

See the Selenium [site](http://docs.seleniumhq.org/) for documation on usage within your test code.

### Issues

If you have any problems with or questions about this image, please contact us through a [Github issue](https://github.com/SeleniumHQ/docker-selenium/issues). If you have any problems with or questions about Selenium, please contact us through Selenium's [Bug Tracker](https://github.com/SeleniumHQ/selenium/issues).
