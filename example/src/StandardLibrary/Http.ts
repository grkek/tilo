class Body {
  constructor(parameters: Body = {} as Body) { }
};

class Request {
  method?: string;
  url: string;

  constructor(url: string) {
    this.url = url;
  }

  get(): Response {
    this.method = "GET";
    //@ts-expect-error
    const response = Http__Get(this.url);

    return new Response(
      response.statusCode,
      response.body,
      response.headers
    );
  }

  post(body: any): Response {
    this.method = "POST";

    //@ts-expect-error
    const response = Http__Post(this.url, JSON.stringify(body));

    return new Response(
      response.statusCode,
      response.body,
      response.headers
    );
  }

  put(body: any) : Response {
    this.method = "PUT";

    //@ts-expect-error
    const response = Http__Put(this.url, JSON.stringify(body));

    return new Response(
      response.statusCode,
      response.body,
      response.headers
    );
  }

  delete(body: any) : Response {
    this.method = "DELETE";

    //@ts-expect-error
    const response = Http__Delete(this.url, JSON.stringify(body));

    return new Response(
      response.statusCode,
      response.body,
      response.headers
    );
  }
};

class Response {
  statusCode: number;
  body: any;
  headers: any;

  constructor(statusCode: number, body: string, headers: any) {
    this.statusCode = statusCode;
    this.headers = headers;

    try{
      this.body = JSON.parse(body);
    } catch {
      this.body = {};
    }
  }
};



export { Request, Response };