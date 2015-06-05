# Domain Configuration

This is a guide on how to configure multiple domain providers with a Rails app (or any web app actually!) and [Heroku](https://heroku.com).

* [GoDaddy](#godaddy)


## GoDaddy

1. On the project folder you need to run the `heroku domains:add heroku domains:add www.example.com` where the `www.example.com` is your actual domain.
2. Then sign in to GoDaddy, go to the domains list, pick your domain or click on the `manage` button. This will take you to your domain configuration.
3. Select the **DNS ZONE FILE** tab
4. Under the **CName (Alias)** table edit the one with the `www` which points to `@`
5. A window will pop, you have to update the **POINTS TO** field to match your heroku app, something like:

![CNAME GoDaddy Configuration](cname_config.png)

**Handle naked domains**

A naked domain is the url we commonly write on the browser navigation bar without the `www`. This is easily achieve with a `forwarding`:

1. In the same window than the last one, but on the **SETTINGS** tab
2. The fourth option is about `forwarding`, click on `manage`
3. A window will pop, click on the **UPDATE FORWARDING** button and on the **FORWARD TO:** field type in your full domain (www.example.com)
4. The redirect type should be `301 (Permanent)` and the forward settings should be `Forward only`
5. Make sure you have the `Update my nameservers and DNS settings to support this change. (Recommended)` option checked.

![CNAME GoDaddy Forwarding](forwarding.png)

Thats it, you are done! You just have to wait until the server propagates and resolves correctly.
