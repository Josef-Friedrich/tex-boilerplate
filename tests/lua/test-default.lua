require('busted.runner')()

local boilerplate = require('boilerplate')

describe('Boilerplate example test', function()
  it('boilerplate',
    function()
        assert.is.equal(boilerplate.boilerplate(), 'boilerplate')
    end)

end)
