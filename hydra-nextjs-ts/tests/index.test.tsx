import { render } from '@testing-library/react';

import Home from '@/pages/index';

describe('HomePage', () => {
  it('displays auth links', () => {
    const result = render(<Home />);
    const links = result.container.querySelectorAll('a');
    expect(links.length).toEqual(4);
    expect(links[0].innerHTML).toEqual('Sign-in');
    expect(links[1].innerHTML).toEqual('Sign-up');
    expect(links[2].innerHTML).toEqual('Consent');
    expect(links[3].innerHTML).toEqual('Sign-out');
  });
});
