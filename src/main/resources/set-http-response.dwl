%dw 2.0
output application/json
---
error.errorType.asString as String match {
    // List of all standard API-related errors.
	case "APIKIT:BAD_REQUEST" -> {
		"code": 400,
		"reason": "Bad Request",
	}
	case "HTTP:BAD_REQUEST" -> {
		"code": 400,
		"reason": "Bad Request",
	}
	case "HTTP:PARSING" -> {
		"code": 400,
		"reason": "Bad Request",
	}
	case "HTTP:CLIENT_SECURITY" -> {
		"code": 401,
		"reason": "Unauthorized",
	}	
	case "HTTP:SECURITY" -> {
		"code": 401,
		"reason": "Unauthorized",
	}
	case "MULE:SECURITY" -> {
		"code": 401,
		"reason": "Unauthorized",
	}
	case "HTTP:UNAUTHORIZED" -> {
		"code": 401,
		"reason": "Unauthorized",
	}
	case "HTTP:FORBIDDEN" -> {
		"code": 403,
		"reason": "Forbidden",
	}	
	case "HTTP:NOT_FOUND" -> {
		"code": 404,
		"reason": "Not Found",
	}
	case "APIKIT:NOT_FOUND" -> {
		"code": 404,
		"reason": "Not Found",
	}
	case "APIKIT:METHOD_NOT_ALLOWED" -> {
		"code": 405,
		"reason": "Method Not Allowed",
	}
	case "HTTP:METHOD_NOT_ALLOWED" -> {
		"code": 405,
		"reason": "Method Not Allowed",
	}
	case "APIKIT:NOT_ACCEPTABLE" -> {
		"code": 406,
		"reason": "Not Acceptable",
	}
	case "HTTP:NOT_ACCEPTABLE" -> {
		"code": 406,
		"reason": "Not Acceptable",
	}
	case "HTTP:TIMEOUT" -> {
		"code":408,
		"reason": "Request Timeout",
	}
	case "APIKIT:UNSUPPORTED_MEDIA_TYPE" -> {
		"code": 415,
		"reason": "Unsupported Media Type",
	}
	case "HTTP:UNSUPPORTED_MEDIA_TYPE" -> {
		"code": 415,
		"reason": "Unsupported Media Type",
	}
	case "HTTP:TOO_MANY_REQUESTS" -> {
      "code": 429,
      "reason": "Too Many Requests",
	}
	case "APIKIT:NOT_IMPLEMENTED" -> {
		"code": 501,
		"reason": "Not Implemented",
	}
	case "HTTP:NOT_IMPLEMENTED" -> {
		"code": 501,
		"reason": "Not Implemented",
	}
	case "HTTP:BAD_GATEWAY" -> {
		"code": 502,
		"reason": "Bad Gateway",
	}
	case "HTTP:CONNECTIVITY" -> {
		"code": 503,
		"reason": "Service Unavailable",
	}
	case "HTTP:RETRY_EXHAUSTED" -> {
		"code": 503,
		"reason": "Service Unavailable",
	}
	case "HTTP:SERVICE_UNAVAILABLE" -> {
		"code": 503,
		"reason": "Service Unavailable",
	}
	// Default error if no matching errors.
	else -> {
		code: 500,
		reason: "Server Error",
    }
}
