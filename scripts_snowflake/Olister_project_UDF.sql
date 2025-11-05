CREATE OR REPLACE FUNCTION sentiment_analysis(review_text STRING)
RETURNS STRING
LANGUAGE PYTHON
RUNTIME_VERSION = '3.10'
PACKAGES = ('textblob')
HANDLER = 'analyze_sentiment'
AS
$$
def analyze_sentiment(s):
    from textblob import TextBlob
    if s is None:
        return "neutral"
    score = TextBlob(s).sentiment.polarity
    if score > 0.1:
        return "positive"
    elif score < -0.1:
        return "negative"
    else:
        return "neutral"
$$;