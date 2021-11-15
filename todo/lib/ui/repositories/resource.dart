enum ResourceState { loading, error, success }

class Resource<T> {
  /// state of the resource
  /// [ResourceState.success] - data exists
  /// [ResourceState.loading] - data is currently loading,
  /// [ResourceState.error] - error when fetching data,
  final ResourceState state;

  /// data exists when success, otherwise may be null
  final T? data;

  /// Localized error that will be shown in the widget or toast
  /// Only exists when state is error
  final String localizedError;

  /// It is supposed to be called only when state is [ResourceState.success]
  T get successData => data!;

  const Resource._inner({
    required this.state,
    required this.data,
    required this.localizedError,
  });

  static Resource<T> success<T>(T data) {
    return Resource._inner(
        state: ResourceState.success, data: data, localizedError: "");
  }

  static Resource<T> loading<T>(T? data) {
    return Resource._inner(
        state: ResourceState.loading, data: data, localizedError: "");
  }

  static Resource<T> error<T>(String localizedError) {
    return Resource._inner(
        state: ResourceState.loading,
        data: null,
        localizedError: localizedError);
  }
}
