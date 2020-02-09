public class ClassForRestAPI {
    
    private final String clientId = '';
    private final String clientSecret = '';
    private final String username = '';
    private final String password = '';
   
    
    public void callGetAccount() {
        ClassForRestAPI cls = new ClassForRestAPI();
        String accessToken = cls.ReturnAccessToken ();
        
        if(accessToken != null){
            Http h2 = new Http();
            HttpRequest req1 = new HttpRequest();
            req1.setHeader('Authorization','OAuth' + accessToken);
            req1.setHeader('Content-Type','application/json');
            req1.setHeader('accept','application/json');
            req1.setMethod('GET');
            
            String endPoint = 'https://login.salesforce.com/services/apexrest/v1/getAccounts/';
            req1.setEndpoint(endPoint);
            
            HttpResponse res1 = h2.send(req1);
            System.debug('===res1 from other org===>'+ res1);
            
            //String trimmedResponse = res1.getBody().unescapeCsv().remove('\\');
            //system.debug('@@@RESPONSE@@'+trimmedResponse);
            
            //JSONParser parser = JSON.createParser(res1.getBody());
            //System.debug('======value in the parser==='+parser);
        }
    }
    
    public String ReturnAccessToken ()
    {
        String endPoint = 'https://login.salesforce.com/services/oauth2/token';
        String reqbody = 'grant_type=password&client_id='+clientId+'&client_secret='+clientSecret+'&username='+username+'&password='+password;
        
        
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setBody(reqbody);
        req.setMethod('POST');
        req.setHeader('Content-Type','application/x-www-form-urlencoded');
        req.setBody(reqbody);
        req.setEndpoint(endPoint);
        System.debug('====reqbody===>'+ reqbody);
        
        HttpResponse res = h.send(req);
        OAuth2 objAuthenticationInfo = (OAuth2)JSON.deserialize(res.getbody(), OAuth2.class);
        //RequestWrapper reqst=new RequestWrapper();
        
        System.debug('====resres===>'+ res);
        
        System.debug('BODY: '+res.getBody());
        System.debug('STATUS:'+res.getStatus());
        System.debug('STATUS_CODE:'+res.getStatusCode());
        
        return '';
        //deserializeResponse response = (deserializeResponse)JSON.deserialize(res.getbody(),deserializeResponse.class);
        //system.debug('@@@@access_token@@'+response );
        //return response.access_token;
    }
    
    public class deserializeResponse
    {
        public String id;
        public String access_token;
    }
    public class OAuth2{
        public String id{get;set;}
        public String issued_at{get;set;}
        public String instance_url{get;set;}
        public String signature{get;set;}
        public String access_token{get;set;}
    }
}