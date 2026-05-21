USE DATABASE yelp_db;
USE SCHEMA raw_data;

CREATE OR REPLACE FUNCTION analyze_sentiment(text STRING)
RETURNS STRING
LANGUAGE PYTHON
RUNTIME_VERSION = '3.9'
PACKAGES = ('textblob')
HANDLER = 'sentiment_analyzer'
AS
$$
from textblob import TextBlob

def sentiment_analyzer(text):
    if text is None:
        return 'Neutral'

    analysis = TextBlob(text)

    if analysis.sentiment.polarity > 0:
        return 'Positive'
    elif analysis.sentiment.polarity == 0:
        return 'Neutral'
    else:
        return 'Negative'
$$;

