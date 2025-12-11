import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'matching_cubit.dart';
import 'matching_state.dart';

class MatchingPage extends StatelessWidget {
  const MatchingPage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MatchingCubit, MatchingState>(
      listener: (context, state) {
        final action = state.lastAction;
        if (action == null) return;
        final text = action == 'like' ? 'Liked' : 'Passed';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(text), duration: const Duration(milliseconds: 600)),
        );
      },
      builder: (context, state) {
        final profile = state.current;
        return Scaffold(
          appBar: AppBar(
            leading: const Icon(Icons.menu),
            centerTitle: true,
            title: const Text('BOO'),
            actions: const [Padding(padding: EdgeInsets.only(right: 12), child: Icon(Icons.bolt))],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: 0,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Match'),
              BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
              BottomNavigationBarItem(icon: Icon(Icons.add_circle_outline), label: 'Create'),
              BottomNavigationBarItem(icon: Icon(Icons.public), label: 'Universes'),
              BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: 'Messages'),
            ],
          ),
          body: profile == null
              ? const Center(child: Text('No more profiles'))
              : Stack(
                  children: [
                    Column(
                      children: [
                        const SizedBox(height: 8),
                        const _SegmentTabs(),
                        const SizedBox(height: 12),
                        Expanded(
                          child: Center(
                            child: _ProfileCard(profile: profile),
                          ),
                        ),
                        const SizedBox(height: 100),
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: SafeArea(
                        minimum: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const _RoundIcon(icon: Icons.share, color: Colors.teal),
                            _RoundIcon(
                              icon: Icons.close,
                              color: Colors.red,
                              onTap: () => context.read<MatchingCubit>().pass(),
                            ),
                            _RoundIcon(
                              icon: Icons.favorite,
                              color: Colors.pink,
                              onTap: () => context.read<MatchingCubit>().like(),
                            ),
                            const _RoundIcon(icon: Icons.star, color: Colors.amber),
                            const _RoundIcon(icon: Icons.send, color: Colors.blue),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}

class _SegmentTabs extends StatelessWidget {
  const _SegmentTabs();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.teal,
            borderRadius: BorderRadius.circular(24),
          ),
          child: const Text('NEW SOULS',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
        ),
        const SizedBox(width: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(24),
          ),
          child: const Text('FOR YOU', style: TextStyle(fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }
}

class _ProfileCard extends StatelessWidget {
  final dynamic profile;
  const _ProfileCard({required this.profile});
  @override
  Widget build(BuildContext context) {
    final card = ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Stack(
        children: [
          Image.network(profile.images.first,
              fit: BoxFit.cover, width: double.infinity, height: double.infinity),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.3),
                    Colors.black.withOpacity(0.6)
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('${profile.name}',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700)),
                      const SizedBox(width: 8),
                      if (profile.verified)
                        const Icon(Icons.verified, color: Colors.teal, size: 20),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.work_outline, color: Colors.white, size: 16),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(profile.role, style: const TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined, color: Colors.white, size: 16),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(profile.location, style: const TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    children: [
                      _Chip(text: '${profile.age}', color: Colors.pink),
                      _Chip(text: profile.mbti, color: Colors.teal),
                      _Chip(text: profile.sign, color: Colors.black87, textColor: Colors.white),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
    return AspectRatio(
      aspectRatio: 3 / 4,
      child: Transform.rotate(
          angle: -0.03,
          child: Material(elevation: 6, borderRadius: BorderRadius.circular(24), child: card)),
    );
  }
}

class _Chip extends StatelessWidget {
  final String text;
  final Color color;
  final Color? textColor;
  const _Chip({required this.text, required this.color, this.textColor});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(16)),
      child: Text(text,
          style: TextStyle(color: textColor ?? Colors.white, fontWeight: FontWeight.w600)),
    );
  }
}

class _RoundIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;
  const _RoundIcon({required this.icon, required this.color, this.onTap});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 64,
      height: 64,
      child: Material(
        color: Colors.white,
        shape: const CircleBorder(),
        elevation: 4,
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onTap,
          child: Center(child: Icon(icon, color: color, size: 28)),
        ),
      ),
    );
  }
}
