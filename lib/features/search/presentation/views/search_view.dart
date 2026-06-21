import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:workspace/core/di/injection_container.dart';
import 'package:workspace/core/navigation/app_navigator.dart';
import 'package:workspace/core/styles/app_colors.dart';
import 'package:workspace/core/styles/app_image.dart';
import 'package:workspace/core/widgets/text_field_widget.dart';
import 'package:workspace/features/search/domain/entities/search_result.dart';
import 'package:workspace/features/search/presentation/cubit/search_cubit.dart';
import 'package:workspace/features/search/presentation/widgets/no_result.dart';

const _fakeResult = SearchResultItem(id: 0, companyName: 'شركة المساحات', provinceName: 'غزة');

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<SearchCubit>()..loadHistory(),
      child: const _SearchBody(),
    );
  }
}

class _SearchBody extends StatefulWidget {
  const _SearchBody();

  @override
  State<_SearchBody> createState() => _SearchBodyState();
}

class _SearchBodyState extends State<_SearchBody> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _focusNode.requestFocus());
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final nav = sl<AppNavigator>();
    final cubit = context.read<SearchCubit>();
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 24.w),
          child: BlocBuilder<SearchCubit, SearchState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      InkWell(onTap: nav.back, child: Icon(Icons.arrow_back, size: 24.r)),
                      SizedBox(width: 12.w),
                      Expanded(child: _searchField(state, cubit)),
                    ],
                  ),
                  if (state.showHistory) ...[
                    SizedBox(height: 24.h),
                    Text(
                      'البحث الاخير',
                      style: GoogleFonts.tajawal(
                        color: const Color(0xFF212121),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    _historyChips(state, cubit),
                  ],
                  Expanded(child: _results(state, nav)),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _searchField(SearchState state, SearchCubit cubit) {
    return TextFieldWidgets(
      controller: _controller,
      focusNode: _focusNode,
      hint: 'ابحث عن مساحات العمل...',
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.text,
      icon: IconButton(
        onPressed: () {},
        icon: SvgPicture.asset(AppSvg.circumSearchSvg, color: const Color(0xFFBDBDBD)),
      ),
      suffixIcon: state.query.trim().isEmpty
          ? const SizedBox.shrink()
          : IconButton(
              onPressed: () {
                _controller.clear();
                cubit.clearResults();
              },
              icon: CircleAvatar(
                radius: 14.r,
                backgroundColor: const Color(0xFFEEEEEE),
                child: const Icon(Icons.close, color: Colors.white),
              ),
            ),
      onChanged: (value) {
        cubit.setQuery(value ?? '');
        return null;
      },
      onFieldSubmitted: (value) {
        cubit.search(value ?? '');
        return null;
      },
    );
  }

  Widget _historyChips(SearchState state, SearchCubit cubit) {
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: List.generate(state.history.length, (index) {
        final term = state.history[index];
        return InkWell(
          onTap: () {
            _controller.text = term;
            cubit.search(term);
          },
          child: Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(2.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () => cubit.removeHistory(index),
                  child: CircleAvatar(
                    radius: 8.r,
                    backgroundColor: const Color(0xFFBDBDBD),
                    child: Icon(Icons.close, color: Colors.white, size: 12.r),
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  term,
                  style: GoogleFonts.tajawal(
                    color: const Color(0xFF212121),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _results(SearchState state, AppNavigator nav) {
    if (state.status == SearchStatus.loading) {
      return Skeletonizer(
        enabled: true,
        child: ListView.separated(
          itemCount: 6,
          separatorBuilder: (_, __) => const Divider(),
          itemBuilder: (_, __) => _resultRow(_fakeResult, null),
        ),
      );
    }
    if (state.status == SearchStatus.loaded && state.results.isEmpty) {
      return const Column(children: [Spacer(), NoResult(), Spacer()]);
    }
    if (state.results.isEmpty) return const SizedBox.shrink();
    return ListView.separated(
      itemCount: state.results.length,
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (context, index) {
        final item = state.results[index];
        return _resultRow(item, () => nav.toDetails(item.id));
      },
    );
  }

  Widget _resultRow(SearchResultItem item, VoidCallback? onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4.h),
        child: Row(
          children: [
            SvgPicture.asset(AppSvg.circumSearchSvg, width: 24.w, height: 24.w),
            SizedBox(width: 8.w),
            Text(
              item.companyName,
              style: GoogleFonts.tajawal(
                color: const Color(0xFF212121),
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: 4.w),
            Text(
              item.provinceName,
              style: GoogleFonts.tajawal(
                color: const Color(0xFF9E9E9E),
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
