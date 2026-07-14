function greet(name) {
    return `Hello, ${name}!`;
}

module.exports = greet;

if (require.main === module) {
    const name = process.argv[2] || 'World';
    console.log(greet(name));
}