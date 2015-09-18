require './app'

describe 'array_marge' do
  array1 = [
    [false, false],
    [true, false],
    [false, true],
    [true, true],
    [true, true],
    [true, true],
    [true, true]
  ]

  array2 = [
    [true, true],
    [true, true],
    [true, true],
    [true, true],
    [false, true],
    [true, false],
    [false, false]
  ]

  expected = [
    [false, false, false, true, true],
    [true,  false, false, true, true],
    [false, true, false, true, true],
    [true,  true, false, true, true],
    [true,  true, false, false, true],
    [true,  true, false, true, false],
    [true,  true, false, false, false]
  ]

  it 'mergeable' do
    expect(join_digi(array1, array2)).to eq expected
  end
end
