# SSL Certificates & Stuff

## Try Let's Encrypt for development purposes - and maybe even for production

We have "Let's Encrypt" as a blip in our tech radar. I'll be using it to secure
the icalialabs domains...

## Types of certificate by domain

### Single domain

### Multiple domain

### Wildcard domain

This is the one you might want for projects where we want flexibility over the
quantity of (sub)domains covered by the certificate without re-issuing the 
certificate or running the certification process again.

Keep in mind, however, that the "Extended Validation (EV)" (a.k.a "The Green
Bar") won't be available in this kind of certificate. According to [Network Solutions](http://www.networksolutions.com/support/why-can-t-i-get-a-wildcard-extended-validation-ev-ssl-certificate/):

> In order to ensure that EV SSL Certificates are not issued fraudulently or misused after issuance, the regulatory body governing the issuance of EV SSL Certificates known as the CA/B Forum decided to require that issuing CA's validate the legitimacy of each and every Web address to which an EV SSL Certificate is assigned.  Therefore, the issuance of "Wildcard" EV SSL Certificates for Web addresses such as "*.networksolutions.com" is not permitted.  If you would like to purchase multiple EV SSL Certificates to replace your Organizationally Validated Wildcard SSL Certificate, contact Customer Support to inquire about our volume discounts.


