import {
  LOGIN,
  LOGOUT,
  SIGNUP,
  receiveCurrentUser,
  receiveErrors
} from '../actions/session_actions';
import {
  login,
  logout,
  signup
} from '../util/session_api_util';

let defaultState = {};


export default ({ dispatch }) => next => action => {
  const loginSuccess = user => dispatch(receiveCurrentUser(user));
  const errorCB = errors => dispatch(receiveErrors(errors.responseJSON));

  switch (action.type) {
    case LOGIN:
      login(action.user, loginSuccess, errorCB);
      return next(action);
    case SIGNUP:
      signup(action.user, loginSuccess, errorCB);
      return next(action);
    case LOGOUT:
      logout(() => next(action), errorCB);
      break;
    default:
      return next(action);
  }
};
