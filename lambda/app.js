exports.handler = async (event) => {
  try {
    const word = event.queryStringParameters?.word || event.word || ''
    const letterCount = word.replace(/[^a-zA-Z]/g, '').length

    return {
      statusCode: 200,
      body: JSON.stringify({
        word,
        totalLetters: letterCount,
      }),
    }
  } catch (error) {
    return {
      statusCode: 500,
      body: JSON.stringify({ error: error.message }),
    }
  }
}
