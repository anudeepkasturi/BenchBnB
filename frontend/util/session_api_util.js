export const signup = (user, success, error) =>
$.ajax({
  url: "api/users",
  type: "post",
  data: { user },
  dataType: "json",
  success,
  error
  });

export const login = (user, success, error) => {
  $.ajax({
    url: "api/sessions",
    type: "post",
    data: { user },
    dataType: "json",
    success,
    error
  });
};

export const logout = (success, error) => {
 $.ajax({
  url: "api/sessions",
  type: "delete",
  dataType: "json",
  success,
  error
  });
};
