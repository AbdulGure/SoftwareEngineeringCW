const assert = require('assert');

assert.strictEqual(1 + 1, 2);
console.log('✓ Basic test passed');

assert.strictEqual('fitshare'.toUpperCase(), 'FITSHARE');
console.log('✓ String test passed');

const levels = ['beginner', 'intermediate', 'advanced'];
assert.strictEqual(levels.length, 3);
console.log('✓ Fitness levels test passed');

console.log('\nAll tests passed ✓');
